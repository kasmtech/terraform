resource "digitalocean_project" "project" {
  name = "${var.project_name}"
  description = "Deployment for ${var.project_name}"
  purpose = "Kasm Workspaces"
  environment = "Development"
  resources = [
    digitalocean_droplet.kasm-server.urn,
    digitalocean_domain.default.urn
  ]
}
