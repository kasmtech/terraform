resource "digitalocean_domain" "default" {
  name = var.do_domain_name
}

data "digitalocean_domain" "data-default" {
  name = digitalocean_domain.default.name
}

resource "digitalocean_record" "static" {
  domain = digitalocean_domain.default.name
  type   = "A"
  name   = "static"
  value  = digitalocean_loadbalancer.www-lb.ip
}

resource "digitalocean_certificate" "cert" {
  name    = "${var.project_name}-cert"
  type    = "lets_encrypt"
  domains = [digitalocean_domain.default.name]

  lifecycle {
    create_before_destroy = true
  }
}

data "digitalocean_certificate" "data-cert" {
  name = digitalocean_certificate.cert.name
}
