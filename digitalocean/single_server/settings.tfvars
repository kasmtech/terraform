## Kasm deployment settings
project_name         = "contoso"
do_domain_name       = "kasm.contoso.com"
digital_ocean_region = "nyc3"
vpc_subnet_cidr      = "10.0.0.0/24"

## DO Authentication variables
ssh_key_fingerprints = ["c2:4c:f2:5d:0c:59:5a:3f:93:a2:9d:25:94:24:9a:b1"]

## VM Settings
digital_ocean_image        = "docker-20-04"
digital_ocean_droplet_slug = "s-2vcpu-4gb-intel"
swap_size                  = 2048

## Kasm passwords
user_password        = "changeme"
admin_password       = "changeme"

## VM Access subnets
allow_ssh_cidrs      = ["0.0.0.0/0"]
allow_kasm_web_cidrs = ["0.0.0.0/0"]

## Kasm download URL
kasm_build_url       = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.12.0.d4fd8a.tar.gz"