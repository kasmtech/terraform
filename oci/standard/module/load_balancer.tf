resource "oci_load_balancer" "public" {
  shape          = "flexible"
  compartment_id = var.compartment_ocid
  subnet_ids     = [oci_core_subnet.lb.id]

  shape_details {
    minimum_bandwidth_in_mbps = 10
    maximum_bandwidth_in_mbps = 1000
  }

  display_name = "${var.project_name}-kasm-load_balancer"
}

resource "oci_load_balancer_certificate" "public" {
  certificate_name = "${var.project_name}-kasm-cert"
  load_balancer_id = oci_load_balancer.public.id

  ca_certificate     = var.letsencrypt_server_type == "" ? file(var.kasm_ssl_crt_path) : acme_certificate.this.certificate_pem
  public_certificate = var.letsencrypt_server_type == "" ? file(var.kasm_ssl_crt_path) : acme_certificate.this.certificate_pem
  private_key        = var.letsencrypt_server_type == "" ? file(var.kasm_ssl_key_path) : tls_private_key.certificate.private_key_pem

  lifecycle {
    create_before_destroy = true
  }
}

resource "oci_load_balancer_backend_set" "public" {
  name             = "${var.project_name}-kasm-backend_set"
  load_balancer_id = oci_load_balancer.public.id
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
      "TLSv1.2"
    ]
    cipher_suite_name       = data.oci_load_balancer_ssl_cipher_suite.this.name
    certificate_name        = oci_load_balancer_certificate.public.certificate_name
    verify_peer_certificate = false
  }
}

resource "oci_load_balancer_backend" "public" {
  count = var.num_webapps

  backendset_name  = oci_load_balancer_backend_set.public.name
  backup           = false
  drain            = false
  load_balancer_id = oci_load_balancer.public.id
  ip_address       = oci_core_instance.webapp[(count.index)].private_ip
  offline          = false
  port             = 443
  weight           = 1
}

resource "oci_load_balancer_listener" "kasm_https_ssl_listener" {
  name                     = "${var.project_name}-https-ssl-listener"
  load_balancer_id         = oci_load_balancer.public.id
  default_backend_set_name = oci_load_balancer_backend_set.public.name
  port                     = "443"
  protocol                 = "HTTP"

  ssl_configuration {
    protocols = [
      "TLSv1.2"
    ]
    server_order_preference = "ENABLED"
    verify_peer_certificate = false
    cipher_suite_name       = data.oci_load_balancer_ssl_cipher_suite.this.name
    certificate_name        = oci_load_balancer_certificate.public.certificate_name
  }
}

data "oci_load_balancer_ssl_cipher_suite" "this" {
  name             = "oci-default-ssl-cipher-suite-v1"
  load_balancer_id = oci_load_balancer.public.id
}
