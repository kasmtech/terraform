## Kasm deployment settings
project_name         = "contoso"
do_domain_name       = "kasm.contoso.com"
digital_ocean_region = "nyc3"
vpc_subnet_cidr      = "10.0.0.0/24"

## DO Authentication variables
ssh_key_fingerprints = []

## VM Settings
digital_ocean_image        = "docker-20-04"
digital_ocean_droplet_slug = "s-2vcpu-4gb-intel"
swap_size                  = 2

## Kasm passwords
user_password  = "changeme"
admin_password = "changeme"

## VM Access subnets
allow_ssh_cidrs      = ["0.0.0.0/0"]
allow_kasm_web_cidrs = ["0.0.0.0/0"]

## Kasm download URL
kasm_build_url = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.16.1.98d6fa.tar.gz"