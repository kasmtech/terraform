module "kasm" {
  source = "./module"
  oci_domain_name         = "kasm.contoso.com"
  project_name            = "contoso"

  tenancy_ocid            = ""
  user_ocid               = ""
  compartment_ocid        = ""

  fingerprint             = ""
  private_key_path        = "./oci-private-key.pem"
  ssh_authorized_keys     = "./authorized_keys"
  kasm_ssl_crt_path       = "./kasm_ssl.crt"
  kasm_ssl_key_path       = "./kasm_ssl.key"

  region                  = "us-ashburn-1"
  instance_image_ocid     = "ocid1.image.oc1.iad.aaaaaaaafg6lg7dejwjebjqontwzyvutgf6qs5awyze6fgoiqepyj5qkvcuq"
  num_agents              = "2"
  num_webapps             = "2"

  kasm_build_url          = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.9.0.077388.tar.gz"
  allow_ssh_cidr          = "0.0.0.0/0"
  allow_web_cidr          = "0.0.0.0/0"
  manager_token           = "changeme"
  admin_password          = "changeme"
  user_password           = "changeme"
  redis_password          = "changeme"
  database_password       = "changeme"
}