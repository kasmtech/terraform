resource "oci_load_balancer_load_balancer" "kasm_load_balancer" {
    compartment_id = var.compartment_ocid
    display_name = "Kasm-${var.project_name}-lb"
    shape = "100Mbps"
    subnet_ids = [oci_core_subnet.kasm-webapp-subnet.id, oci_core_subnet.kasm-webapp-subnet-2.id]
    is_private = false
}

resource "oci_load_balancer_certificate" "kasm_lb_certificate" {
    certificate_name = "${var.project_name}-kasm-cert-2"
    load_balancer_id = oci_load_balancer_load_balancer.kasm_load_balancer.id

    ca_certificate =  file(var.kasm_ssl_crt_path)
    public_certificate = file(var.kasm_ssl_crt_path)
    private_key = file(var.kasm_ssl_key_path)

    lifecycle {
        create_before_destroy = true
    }
}

resource "oci_load_balancer_backend_set" "kasm-webapps-backend-set" {
  health_checker {
    interval_ms         = "10000"
    port                = "443"
    protocol            = "HTTP"
    response_body_regex = ""
    retries             = "3"
    return_code         = "200"
    timeout_in_millis   = "3000"
    url_path            = "/api/__healthcheck"
  }
  ssl_configuration {
    certificate_name = oci_load_balancer_certificate.kasm_lb_certificate.certificate_name
    verify_peer_certificate = false
  }

  load_balancer_id = oci_load_balancer_load_balancer.kasm_load_balancer.id
  name             = "kasm-webapps-lb-backend-set"
  policy           = "ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "webapp-ld-backed" {
    count = var.num_webapps
    backendset_name  = oci_load_balancer_backend_set.kasm-webapps-backend-set.name
    backup           = "false"
    drain            = "false"
    load_balancer_id = oci_load_balancer_load_balancer.kasm_load_balancer.id
    ip_address       = oci_core_instance.kasm_webapp_instance[count.index].private_ip
    offline          = "false"
    port             = "443"
    weight           = "1"
}

resource "oci_load_balancer_listener" "kasm_https_ssl_listener" {
  load_balancer_id         = oci_load_balancer_load_balancer.kasm_load_balancer.id
  name                     = "${var.project_name}-https-ssl-listener"
  default_backend_set_name = oci_load_balancer_backend_set.kasm-webapps-backend-set.name
  port                     = "443"
  protocol                 = "HTTP"

  ssl_configuration {
    certificate_name = oci_load_balancer_certificate.kasm_lb_certificate.certificate_name
    verify_peer_certificate = false
  }
}
