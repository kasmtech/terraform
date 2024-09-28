## AWS Environment settings
ssh_authorized_keys     = ""
aws_primary_region      = ""
aws_domain_name         = "example.kasmweb.com"
primary_vpc_subnet_cidr = "10.0.0.0/16"

## Kasm deployment project
project_name = ""

## Kasm passwords
database_password          = "changeme"
redis_password             = "changeme"
user_password              = "changeme"
admin_password             = "changeme"
manager_token              = "changeme"
service_registration_token = "changeme"

## Kasm download URL
kasm_build = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.16.0.a1d5b7.tar.gz"

## VM Public Access subnets
web_access_cidrs = ["0.0.0.0/0"]

## AWS SSM setup for console/SSH access to VMs behind NAT gateway
create_aws_ssm_iam_role       = true
aws_ssm_iam_role_name         = ""
aws_ssm_instance_profile_name = ""

## Kasm Server Settings
swap_size                 = 2
primary_region_ec2_ami_id = ""

## Kasm Webapp Instance Settings
num_webapps          = 2
webapp_instance_type = "t3.small"
webapp_hdd_size_gb   = 50

## Kasm DB Instance Settings
db_instance_type = "t3.medium"
db_hdd_size_gb   = 80

## Kasm Agent Instance Settings
num_agents          = 2
agent_instance_type = "t3.medium"
agent_hdd_size_gb   = 150

## Kasm CPX Instance Settings
num_cpx_nodes     = 1
cpx_instance_type = "t3.small"
cpx_hdd_size_gb   = 50

## Kasm Dedicated Proxy Instance Settings
num_proxy_nodes     = 2
proxy_hdd_size_gb   = 40
proxy_instance_type = "t3.micro"

## Settings for all additional Agent regions
secondary_regions_settings = {
  region2 = {
    agent_region   = ""
    ec2_ami_id     = ""
    agent_vpc_cidr = "10.1.0.0/16"
  }

  #######################################################################
  ###
  ### Uncomment and update the settings below for an third region.
  ### Copy/paste the settings below (changing the region number) for any
  ### additional regions.
  ###
  ### Make sure to add a provider section for each additional region in
  ### the providers.tf file.
  ###
  #######################################################################
  # region3 = {
  #   agent_region   = ""
  #   ec2_ami_id     = ""
  #   agent_vpc_cidr = "10.2.0.0/16"
  # }
}

## Default tags for all AWS resources
aws_default_tags = {
  Deployed_by     = "Terraform"
  Deployment_type = "Multi-Region"
  Service_name    = "Kasm Workspaces"
  Kasm_version    = "1.16"
}
