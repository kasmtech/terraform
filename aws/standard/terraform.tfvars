## AWS Environment settings
ssh_authorized_keys = ""
aws_region          = ""
aws_domain_name     = "example.kasmweb.com"
vpc_subnet_cidr     = "10.0.0.0/16"

## Kasm deployment settings
kasm_zone_name = ""
project_name   = ""

## Number of each Kasm role to deploy
num_agents    = 2
num_webapps   = 2
num_cpx_nodes = 1

## VM Public Access subnets
web_access_cidrs = ["0.0.0.0/0"]

## AWS SSM setup for console/SSH access to VMs behind NAT gateway
create_aws_ssm_iam_role       = true
aws_ssm_iam_role_name         = ""
aws_ssm_instance_profile_name = ""

## Kasm Server settings
ec2_ami_id = ""
swap_size  = 2

## Kasm Webapp Instance Settings
webapp_instance_type = "t3.small"
webapp_hdd_size_gb   = 50

## Kasm DB Instance Settings
db_instance_type = "t3.medium"
db_hdd_size_gb   = 80

## Kasm Agent Instance Settings
agent_instance_type = "t3.medium"
agent_hdd_size_gb   = 150

## Kasm CPX Instance Settings
cpx_instance_type = "t3.small"
cpx_hdd_size_gb   = 50

## Kasm passwords
database_password          = "changeme"
redis_password             = "changeme"
user_password              = "changeme"
admin_password             = "changeme"
manager_token              = "changeme"
service_registration_token = "changeme"

## Kasm download URL
kasm_build = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.16.1.6efdbd.tar.gz"

## Default tags for all AWS resources
aws_default_tags = {
  Deployed_by     = "Terraform"
  Deployment_type = "Multi-Server"
  Service_name    = "Kasm Workspaces"
  Kasm_version    = "1.16.1"
}
