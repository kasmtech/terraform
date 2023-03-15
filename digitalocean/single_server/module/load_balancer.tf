resource "digitalocean_loadbalancer" "www-lb" {
  name                   = "${var.project_name}-lb"
  region                 = var.digital_ocean_region
  vpc_uuid               = data.digitalocean_vpc.data-kasm_vpc.id
  redirect_http_to_https = true

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 443
    target_protocol = "https"

    certificate_name = data.digitalocean_certificate.data-cert.id
  }

  healthcheck {
    port     = 443
    protocol = "https"
    path     = "/"
  }

  droplet_ids = [data.digitalocean_droplet.data-kasm_server.id]
}
