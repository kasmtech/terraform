## AWS Environment settings
aws_key_pair    = "troy-common-ssh"
aws_region      = "us-east-1"
aws_domain_name = "bryan-test2.sandbox1.kasmweb.net"
vpc_subnet_cidr = "10.0.0.0/16"

## Kasm deployment settings
kasm_zone_name  = "default"
project_name    = "contoso"
num_agents      = 2
num_webapps     = 2
num_guac_nodes  = 1

## Kasm Server settings
agent_instance_type  = "t3.medium"
guac_instance_type   = "t3.medium"
webapp_instance_type = "t3.small"
db_instance_type     = "t3.small"
ec2_ami              = "ami-09cd747c78a9add63"
swap_size            = 2048

## VM Access subnets
ssh_access_cidrs = ["0.0.0.0/0"]
web_access_cidrs = ["0.0.0.0/0"]

## Kasm passwords
database_password          = "changeme"
redis_password             = "changeme"
user_password              = "changeme"
admin_password             = "changeme"
manager_token              = "changeme"
service_registration_token = "changeme"

## Kasm download URL
kasm_build = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.12.0.d4fd8a.tar.gz"

## Default tags for all AWS resources
aws_default_tags = {
  Deployed_by     = "Terraform"
  Deployment_type = "Multi-Server"
  Service_name    = "Kasm Workspaces"
  Kasm_version    = "1.12"
}
