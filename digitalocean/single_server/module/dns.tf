resource "digitalocean_domain" "default" {
  name = "${var.do_domain_name}"
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
  domains = ["${digitalocean_domain.default.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "digitalocean_loadbalancer" "www-lb" {
  name = "${var.project_name}-lb"
  region = "${var.digital_ocean_region}"

  forwarding_rule {
    entry_port = 443
    entry_protocol = "https"

    target_port = 443
    target_protocol = "https"

    certificate_name = digitalocean_certificate.cert.name
  }

  healthcheck {
    port = 443
    protocol = "https"
    path = "/"
  }

  droplet_ids = digitalocean_droplet.kasm-server.*.id
}
