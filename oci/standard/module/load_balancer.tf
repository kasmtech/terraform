resource "oci_load_balancer" "kasm_load_balancer" {
  shape          = "flexible"
  compartment_id = var.compartment_ocid
  subnet_ids     = [for subnet_id in data.oci_core_subnets.data-kasm_webapp_subnets : subnet_id.subnets[0].id]

  shape_details {
    minimum_bandwidth_in_mbps = 10
    maximum_bandwidth_in_mbps = 100
  }

  display_name = "${var.project_name}-kasm-load_balancer"
}

resource "oci_load_balancer_certificate" "kasm_lb_certificate" {
  certificate_name = "${var.project_name}-kasm-cert"
  load_balancer_id = oci_load_balancer.kasm_load_balancer.id

  ca_certificate     = var.letsencrypt_server_type == "" ? file(var.kasm_ssl_crt_path) : acme_certificate.certificate.certificate_pem
  public_certificate = var.letsencrypt_server_type == "" ? file(var.kasm_ssl_crt_path) : acme_certificate.certificate.certificate_pem
  private_key        = var.letsencrypt_server_type == "" ? file(var.kasm_ssl_key_path) : tls_private_key.certificate_private_key.private_key_pem

  lifecycle {
    create_before_destroy = true
  }
}

resource "oci_load_balancer_backend_set" "kasm_load_balancer_backend_set" {
  name             = "${var.project_name}-kasm-backend_set"
  load_balancer_id = oci_load_balancer.kasm_load_balancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = 443
    protocol            = "HTTP"
    response_body_regex = ""
    retries             = 3
    return_code         = 200
    timeout_in_millis   = 3000
    interval_ms         = 10000
    url_path            = "/api/__healthcheck"
  }

  ssl_configuration {
    protocols = [
      "TLSv1.1",
      "TLSv1.2"
    ]
    cipher_suite_name       = data.oci_load_balancer_ssl_cipher_suite.data-kasm_load_balancer_cipher_suite.name
    certificate_name        = oci_load_balancer_certificate.kasm_lb_certificate.certificate_name
    verify_peer_certificate = false
  }
}

resource "oci_load_balancer_backend" "kasm_webapp_load_balancer_backend" {
  count            = var.num_webapps
  backendset_name  = oci_load_balancer_backend_set.kasm_load_balancer_backend_set.name
  backup           = false
  drain            = false
  load_balancer_id = oci_load_balancer.kasm_load_balancer.id
  ip_address       = data.oci_core_instance.data-kasm_webapp_instances[count.index].private_ip
  offline          = false
  port             = 443
  weight           = 1
}

resource "oci_load_balancer_listener" "kasm_https_ssl_listener" {
  name                     = "${var.project_name}-https-ssl-listener"
  load_balancer_id         = oci_load_balancer.kasm_load_balancer.id
  default_backend_set_name = oci_load_balancer_backend_set.kasm_load_balancer_backend_set.name
  port                     = "443"
  protocol                 = "HTTP"

  ssl_configuration {
    protocols = [
      "TLSv1.1",
      "TLSv1.2"
    ]
    server_order_preference = "ENABLED"
    verify_peer_certificate = false
    cipher_suite_name       = data.oci_load_balancer_ssl_cipher_suite.data-kasm_load_balancer_cipher_suite.name
    certificate_name        = oci_load_balancer_certificate.kasm_lb_certificate.certificate_name
  }
}

data "oci_load_balancer_ssl_cipher_suite" "data-kasm_load_balancer_cipher_suite" {
  name             = "oci-default-ssl-cipher-suite-v1"
  load_balancer_id = oci_load_balancer.kasm_load_balancer.id
}
