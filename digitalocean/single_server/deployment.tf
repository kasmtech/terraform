module "kasm" {
  source                     = "./module"
  project_name               = var.project_name
  do_domain_name             = var.do_domain_name
  vpc_subnet_cidr            = var.vpc_subnet_cidr
  digital_ocean_region       = var.digital_ocean_region
  digital_ocean_image        = var.digital_ocean_image
  digital_ocean_droplet_slug = var.digital_ocean_droplet_slug
  swap_size                  = var.swap_size
  kasm_build_url             = var.kasm_build_url
  user_password              = var.user_password
  admin_password             = var.admin_password
  allow_ssh_cidrs            = var.allow_ssh_cidrs
  allow_kasm_web_cidrs       = var.allow_kasm_web_cidrs
  ssh_key_fingerprints       = var.ssh_key_fingerprints
}
