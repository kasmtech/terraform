module "standard" {
  source          = "./module"
  aws_access_key  = ""
  aws_secret_key  = ""
  aws_key_pair    = "Kasm_AWS_KeyPair"
  aws_region      = "us-east-2"
  aws_domain_name = "default"
  project_name    = "default-FSxN"
  num_agents      = "2"
  num_webapps     = "2"



  agent_instance_type  = "t3.medium"
  webapp_instance_type = "t3.small"
  db_instance_type     = "t3.small"
  ec2_ami              = "ami-0747bdcabd34c712a" // ap-southeast-1 "ami-055147723b7bca09a" // us-east-1 "ami-0747bdcabd34c712a" 
  ssh_access_cidr      = "0.0.0.0/0"
  database_password    = "DefaultPass@1#"
  redis_password       = "DefaultPass@1#"
  user_password        = "DefaultPass@1#"
  admin_password       = "DefaultPass@1#"
  manager_token        = "DefaultPass@1#"
  zone_name            = "default"
  kasm_build           = "https://api.github.com/repos/varunrai/kasmtech-terraform/releases/latest"
}


