module "kasm" {
  source          = "./module"
  oci_domain_name = var.oci_domain_name
  project_name    = var.project_name
  kasm_build_url  = var.kasm_build_url
  vcn_subnet_cidr = var.vcn_subnet_cidr

  ## OCI Auth information
  tenancy_ocid        = var.tenancy_ocid
  compartment_ocid    = var.compartment_ocid
  user_ocid           = var.user_ocid
  fingerprint         = var.fingerprint
  private_key_path    = var.private_key_path
  region              = var.region
  ssh_authorized_keys = var.ssh_authorized_keys

  ## SSL Certificate values
  # Let TF generate Let's Encrypt SSL Certificates automatically
  letsencrypt_cert_support_email = var.letsencrypt_cert_support_email
  letsencrypt_server_type        = var.letsencrypt_server_type
  # Bring your own SSL Certificates
  kasm_ssl_crt_path = var.kasm_ssl_crt_path
  kasm_ssl_key_path = var.kasm_ssl_key_path

  instance_image_ocid       = var.instance_image_ocid
  instance_shape            = var.instance_shape
  num_agents                = var.num_agents
  num_webapps               = var.num_webapps
  num_guac_rdp_nodes        = var.num_guac_rdp_nodes
  kasm_agent_vm_settings    = var.kasm_agent_vm_settings
  kasm_database_vm_settings = var.kasm_database_vm_settings
  kasm_webapp_vm_settings   = var.kasm_webapp_vm_settings
  kasm_guac_vm_settings     = var.kasm_guac_vm_settings
  allow_ssh_cidrs           = var.allow_ssh_cidrs
  allow_web_cidrs           = var.allow_web_cidrs
  swap_size                 = var.swap_size

  manager_token              = var.manager_token
  admin_password             = var.admin_password
  user_password              = var.user_password
  redis_password             = var.redis_password
  database_password          = var.database_password
  service_registration_token = var.service_registration_token
}
