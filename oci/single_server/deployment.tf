module "kasm" {
  source          = "./module"
  oci_domain_name = var.oci_domain_name
  project_name    = var.project_name
  kasm_build_url  = var.kasm_build_url
  vcn_subnet_cidr = var.vcn_subnet_cidr

  ## OCI Auth information
  tenancy_ocid     = var.tenancy_ocid
  compartment_ocid = var.compartment_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region

  ## SSL Certificate values
  # Let TF generate Let's Encrypt SSL Certificates automatically
  letsencrypt_cert_support_email = var.letsencrypt_cert_support_email
  letsencrypt_server_type        = var.letsencrypt_server_type
  # Bring your own SSL Certificates
  kasm_ssl_crt_path = var.kasm_ssl_crt_path
  kasm_ssl_key_path = var.kasm_ssl_key_path

  instance_image_ocid  = var.instance_image_ocid
  instance_shape       = var.instance_shape
  swap_size            = var.swap_size
  kasm_server_cpus     = var.kasm_server_cpus
  kasm_server_memory   = var.kasm_server_memory
  kasm_server_hdd_size = var.kasm_server_hdd_size
  allow_ssh_cidrs      = var.allow_ssh_cidrs
  allow_web_cidrs      = var.allow_web_cidrs
  ssh_authorized_keys  = var.ssh_authorized_keys

  admin_password = var.admin_password
  user_password  = var.user_password
}
