module "kasm" {
  source                      = "./module"

  digital_ocean_token         = ""

  do_domain_name              = "kasm.contoso.com"
  project_name                = "contoso"

  digital_ocean_region        = "nyc3"
  digital_ocean_image         = "docker-18-04"
  digital_ocean_droplet_slug  = "s-2vcpu-4gb-intel"
  swap_size                   = 2048

  kasm_build_url              = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.9.0.077388.tar.gz"
  user_password               = "changeme"
  admin_password              = "changeme"
  allow_ssh_cidrs             = ["0.0.0.0/0"]
  ssh_key_fingerprints        = []
}
