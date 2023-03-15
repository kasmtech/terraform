resource "digitalocean_project" "project" {
  name        = var.project_name
  description = "Deployment for ${var.project_name}"
  purpose     = "Kasm Workspaces"
  environment = "Development"
  resources = [
    data.digitalocean_droplet.data-kasm_server.urn,
    data.digitalocean_domain.data-default.urn
  ]
}

resource "digitalocean_tag" "project" {
  name = var.project_name
}

data "digitalocean_tag" "data-project" {
  name = digitalocean_tag.project.name
}
