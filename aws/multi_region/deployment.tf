###########################################################
# Define a primary region.
# This will house the Kasm Workspaces DB, and a set of
# agents/webapps that map to this region.
###########################################################

module "primary_region" {
  source                = "./primary"
  aws_region            = "us-east-1"
  zone_name             = "us-east-1"
  ec2_ami               = "ami-013f17f36f8b1fefb"
  db_instance_type      = "t3.small"
  num_agents            = 2
  agent_instance_type   = "t3.medium"
  num_webapps           = 2
  webapp_instance_type  = "t3.small"



  aws_access_key        = "${var.aws_access_key}"
  aws_secret_key        = "${var.aws_secret_key}"
  project_name          = "${var.project_name}"
  kasm_build            = "${var.kasm_build}"
  database_password     = "${var.database_password}"
  redis_password        = "${var.redis_password}"
  user_password         = "${var.user_password}"
  admin_password        = "${var.admin_password}"
  manager_token         = "${var.manager_token}"
  aws_key_pair          = "${var.aws_key_pair}"
  aws_domain_name       = "${var.aws_domain_name}"
  ssh_access_cidr       = "${var.ssh_access_cidr}"
}


###########################################################
# Add a pair of webapp and agent modules
#   for each additional region desired.
###########################################################

module "us-west-1-webapps" {
  source = "./webapps"
  faux_aws_region       = "us-west-1"
  zone_name             = "us-west-1"
  num_webapps           = 2
  webapp_instance_type  = "t3.small"
  ec2_ami               = "ami-013f17f36f8b1fefb"



  primary_aws_region    = "${module.primary_region.primary_aws_region}"
  webapp_subnet_id_1    = "${module.primary_region.webapp_subnet_1_id}"
  webapp_subnet_id_2    = "${module.primary_region.webapp_subnet_2_id}"
  agent_subnet_id       = "${module.primary_region.agent_subnet_id}"
  aws_access_key        = "${var.aws_access_key}"
  aws_secret_key        = "${var.aws_secret_key}"
  aws_domain_name       = "${var.aws_domain_name}"
  project_name          = "${var.project_name}"
  kasm_build            = "${var.kasm_build}"
  database_password     = "${var.database_password}"
  redis_password        = "${var.redis_password}"
  manager_token         = "${var.manager_token}"
  aws_key_pair          = "${var.aws_key_pair}"
  kasm_db_ip            = "${module.primary_region.kasm_db_ip}"
  primary_vpc_id        = "${module.primary_region.primary_vpc_id}"
  certificate_arn       = "${module.primary_region.certificate_arn}"
  ssh_access_cidr       = "${var.ssh_access_cidr}"
}


module "us-west-1-agents" {
  source = "./agents"
  aws_region            = "us-west-1"
  zone_name             = "us-west-1"
  num_agents            = 2
  agent_instance_type   = "t3.medium"
  ec2_ami               = "ami-08d0eee5e00da8a9b"



  aws_access_key        = "${var.aws_access_key}"
  aws_secret_key        = "${var.aws_secret_key}"
  aws_domain_name       = "${var.aws_domain_name}"
  project_name          = "${var.project_name}"
  kasm_build            = "${var.kasm_build}"
  manager_token         = "${var.manager_token}"
  aws_key_pair          = "${var.aws_key_pair}"
  ssh_access_cidr       = "${var.ssh_access_cidr}"

}

