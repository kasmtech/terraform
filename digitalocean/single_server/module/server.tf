data "template_file" "user_data" {
  template = "${file("${path.module}/files/kasm_server_init.sh")}"
  vars = {
    kasm_build_url  = "${var.kasm_build_url}"
    user_password   = "${var.user_password}"
    admin_password  = "${var.admin_password}"
    swap_size       = "${var.swap_size}"
  }
}

resource "digitalocean_droplet" "kasm-server" {
  ssh_keys           = "${var.ssh_key_fingerprints}"
  image              = "${var.digital_ocean_image}"
  region             = "${var.digital_ocean_region}"
  size               = "${var.digital_ocean_droplet_slug}"
  vpc_uuid           = "${var.vpc_uuid}"
  private_networking = false
  backups            = false
  ipv6               = false
  name               = "${var.project_name}-workspaces"
  tags               = ["${digitalocean_tag.project.id}"]
  user_data          = "${data.template_file.user_data.rendered}"
}

output "kasm_server_ip" {
  value = "${digitalocean_droplet.kasm-server.ipv4_address}"
}

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = "${var.digital_ocean_token}"
}

resource "digitalocean_tag" "project" {
  name = "${var.project_name}"
}
