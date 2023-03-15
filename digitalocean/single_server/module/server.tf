resource "digitalocean_droplet" "kasm-server" {
  ssh_keys = var.ssh_key_fingerprints
  image    = var.digital_ocean_image
  region   = var.digital_ocean_region
  size     = var.digital_ocean_droplet_slug
  vpc_uuid = data.digitalocean_vpc.data-kasm_vpc.id
  backups  = false
  ipv6     = false
  name     = "${var.project_name}-workspaces"
  tags     = [data.digitalocean_tag.data-project.id]
  user_data = templatefile("${path.module}/userdata/kasm_server_init.sh",
    {
      kasm_build_url = var.kasm_build_url
      user_password  = var.user_password
      admin_password = var.admin_password
      swap_size      = var.swap_size
    }
  )
}

data "digitalocean_droplet" "data-kasm_server" {
  id = digitalocean_droplet.kasm-server.id
}
