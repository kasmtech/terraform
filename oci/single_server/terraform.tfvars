## Kasm deployment settings
oci_domain_name = "kasm.contoso.com"
project_name    = "contoso"
vcn_subnet_cidr = "10.0.0.0/16"

## OCI Authentication variables
tenancy_ocid     = "changeme"
user_ocid        = "changeme"
compartment_ocid = "changeme"
fingerprint      = "changeme"
private_key_path = "./oci-private-key.pem"
region           = "us-ashburn-1"

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
admin_password = "changeme"
user_password  = "changeme"

## SSH Public Keys
ssh_authorized_keys = "changeme"

## OCI VM Settings
instance_image_ocid  = ""
instance_shape       = "VM.Standard.E4.Flex"
swap_size            = 2
kasm_server_cpus     = 2
kasm_server_memory   = 2
kasm_server_hdd_size = 120

## Kasm download URL
kasm_build_url = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.15.0.06fdc8.tar.gz"
