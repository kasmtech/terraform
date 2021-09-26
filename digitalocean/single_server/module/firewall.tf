resource "digitalocean_firewall" "workspaces-fw" {
  name = "${var.project_name}-fw"

  tags = ["${digitalocean_tag.project.id}"]

  inbound_rule {
      protocol           = "tcp"
      port_range         = "22"
      source_addresses   = "${var.allow_ssh_cidrs}"
  }

  inbound_rule {
      protocol           = "tcp"
      port_range         = "443"
      source_addresses   = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
      protocol                = "tcp"
      port_range              = "1-65535"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
      protocol                = "udp"
      port_range              = "1-65535"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
      protocol                = "icmp"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
  }
}
