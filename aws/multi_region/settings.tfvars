aws_domain_name         = "kasm.contoso.com"
project_name            = "contoso"
aws_key_pair            = ""
aws_primary_region      = "us-east-1"
primary_vpc_subnet_cidr = "10.0.0.0/16"

database_password          = "changeme"
redis_password             = "changeme"
user_password              = "changeme"
admin_password             = "changeme"
manager_token              = "changeme"

kasm_build       = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.13.0.002947.tar.gz"
ssh_access_cidrs = ["0.0.0.0/0"]
web_access_cidrs = ["0.0.0.0/0"]

swap_size                 = 2048
primary_region_ec2_ami_id = "ami-09cd747c78a9add63"
webapp_instance_type      = "t3.small"
db_instance_type          = "t3.small"
agent_instance_type       = "t3.medium"
webapp_hdd_size_gb        = 40
db_hdd_size_gb            = 40
agent_hdd_size_gb         = 40

## Settings for all additional Agent regions
secondary_regions_settings  = {
  region2 = {
    agent_region         = "us-west-1"
    agent_ec2_ami_id     = "ami-0d221cb540e0015f4"
    agent_instance_type  = "t3.medium"
    agent_hdd_size_gb    = 120
    num_agents           = 2
    agent_vpc_cidr       = "10.1.0.0/16"
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
  #   agent_region         = "eu-central-1"
  #   agent_ec2_ami_id     = "ami-0e067cc8a2b58de59"
  #   agent_instance_type  = "t3.medium"
  #   num_agents           = 2
  #   agent_vpc_cidr       = "10.2.0.0/16"
  # }
}

## Default tags for all AWS resources
aws_default_tags = {
  Deployed_by     = "Terraform"
  Deployment_type = "Multi-Region"
  Service_name    = "Kasm Workspaces"
  Kasm_version    = "1.12"
}
