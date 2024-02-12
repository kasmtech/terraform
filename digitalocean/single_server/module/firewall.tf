resource "digitalocean_firewall" "workspaces-fw" {
  name = "${var.project_name}-fw"

  tags = [digitalocean_tag.project.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.allow_ssh_cidrs
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = var.allow_kasm_web_cidrs
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = var.allow_kasm_web_cidrs
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = var.anywhere
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = var.anywhere
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = var.anywhere
  }
}
