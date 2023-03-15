module "standard" {
  source          = "./module"
  aws_key_pair    = var.aws_key_pair
  aws_region      = var.aws_region
  aws_domain_name = var.aws_domain_name
  project_name    = var.project_name
  num_agents      = var.num_agents
  num_webapps     = var.num_webapps
  num_guac_nodes  = var.num_guac_nodes
  vpc_subnet_cidr = var.vpc_subnet_cidr

  ## Kasm Server settings
  agent_instance_type  = var.agent_instance_type
  guac_instance_type   = var.guac_instance_type
  webapp_instance_type = var.webapp_instance_type
  db_instance_type     = var.db_instance_type
  ec2_ami              = var.ec2_ami
  swap_size            = var.swap_size

  ssh_access_cidrs           = var.ssh_access_cidrs
  web_access_cidrs           = var.web_access_cidrs
  database_password          = var.database_password
  redis_password             = var.redis_password
  user_password              = var.user_password
  admin_password             = var.admin_password
  manager_token              = var.manager_token
  service_registration_token = var.service_registration_token
  kasm_zone_name             = var.kasm_zone_name
  kasm_build                 = var.kasm_build
}
