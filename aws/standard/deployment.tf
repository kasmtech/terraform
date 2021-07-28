module "standard" {
  source                = "./module"
  aws_access_key        = ""
  aws_secret_key        = ""
  aws_key_pair          = ""
  aws_region            = "us-east-1"
  aws_domain_name       = "kasm.contoso.com"
  project_name          = "contoso"
  num_agents            = "2"
  num_webapps           = "2"



  agent_instance_type   = "t3.medium"
  webapp_instance_type  = "t3.small"
  db_instance_type      = "t3.small"
  ec2_ami               = "ami-0747bdcabd34c712a"


  s3_unique_id          = "f3g2dc"
  ssh_access_cidr        = "0.0.0.0/0"
  database_password     = "changeme"
  redis_password        = "changeme"
  user_password         = "changeme"
  admin_password        = "changeme"
  manager_token         = "changeme"
  zone_name             = "default"
  kasm_build            = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.9.0.077388.tar.gz"
}


