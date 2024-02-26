## Kasm deployment settings
oci_domain_name = "kasm.contoso.com"
project_name    = "contoso"
kasm_build_url  = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.14.0.3a7abb.tar.gz"
vcn_subnet_cidr = "10.0.0.0/16"

## OCI Authentication variables
tenancy_ocid     = ""
user_ocid        = ""
compartment_ocid = ""
fingerprint      = ""
region           = "us-ashburn-1"
private_key_path = "./oci-private-key.pem"

## Load Balancer SSL Keys
# Terraform auto-generated Let's Encrypt keys
letsencrypt_cert_support_email = ""
letsencrypt_server_type        = ""

# Bring your own - Load Balancer SSL Keys
kasm_ssl_crt_path = ""
kasm_ssl_key_path = ""

## VM Access subnets
allow_ssh_cidrs = ["0.0.0.0/0"]
allow_web_cidrs = ["0.0.0.0/0"]

## Kasm passwords
manager_token              = "changeme"
admin_password             = "changeme"
user_password              = "changeme"
redis_password             = "changeme"
database_password          = "changeme"
service_registration_token = "changeme"

## SSH Public Key
ssh_authorized_keys = "changeme"

## OCI VM Settings
instance_image_ocid = ""
instance_shape      = "VM.Standard.E4.Flex"
swap_size           = 2048
num_webapps         = 2
num_agents          = 2
num_cpx_nodes       = 1

kasm_webapp_vm_settings = {
  cpus        = 2
  memory      = 2
  hdd_size_gb = 50
}

kasm_database_vm_settings = {
  cpus        = 2
  memory      = 2
  hdd_size_gb = 50
}

kasm_agent_vm_settings = {
  cpus        = 4
  memory      = 8
  hdd_size_gb = 120
}

kasm_cpx_vm_settings = {
  cpus        = 4
  memory      = 4
  hdd_size_gb = 50
}

bastion_vm_settings = {
  cpus        = 1
  memory      = 2
  hdd_size_gb = 50
}
