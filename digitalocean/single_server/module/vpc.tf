resource "digitalocean_vpc" "kasm_vpc" {
  name        = "${var.project_name}-vpc"
  description = "Kasm deployment VPC for ${var.project_name}"
  region      = var.digital_ocean_region
  ip_range    = var.vpc_subnet_cidr
}

data "digitalocean_vpc" "data-kasm_vpc" {
  name = digitalocean_vpc.kasm_vpc.name
}
