module "standard" {
  source                  = "./module"
  aws_key_pair            = var.aws_key_pair
  aws_region              = var.aws_region
  aws_domain_name         = var.aws_domain_name
  project_name            = var.project_name
  num_agents              = var.num_agents
  num_webapps             = var.num_webapps
  num_cpx_nodes           = var.num_cpx_nodes
  vpc_subnet_cidr         = var.vpc_subnet_cidr
  create_aws_ssm_iam_role = var.create_aws_ssm_iam_role
  aws_ssm_iam_role_name   = var.aws_ssm_iam_role_name

  ## Kasm Server settings
  webapp_instance_type = var.webapp_instance_type
  webapp_hdd_size_gb   = var.webapp_hdd_size_gb
  db_instance_type     = var.db_instance_type
  db_hdd_size_gb       = var.db_hdd_size_gb
  agent_instance_type  = var.agent_instance_type
  agent_hdd_size_gb    = var.agent_hdd_size_gb
  cpx_instance_type    = var.cpx_instance_type
  cpx_hdd_size_gb      = var.cpx_hdd_size_gb
  ec2_ami              = var.ec2_ami_id
  swap_size            = var.swap_size

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
