variable "aws_access_key" {
  description = "The AWS access key used for deployment"
}

variable "aws_secret_key" {
  description = "The AWS secret key used for deployment"
}

variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
}

variable "aws_domain_name" {
  description = "The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https"
}

variable "database_password" {
  description = "The password for the database. No special characters"
}

variable "redis_password" {
  description = "The password for the database. No special characters"
}

variable "num_webapps" {
  description = "The number of WebApp role servers to create in the deployment"
}

variable "webapp_instance_type" {
  default = "t3.small"
  description = "The instance type for the webapps"
}

variable "num_agents" {
  default = 0
  description = "The number of Agent Role Servers to create in the deployment"
}

variable "agent_instance_type" {
  default = "t3.medium"
  description = "the instance type for the agents"
}

variable "primary_aws_region" {
  description = "The AWS region for primary region of the deployment. (e.g us-east-1)"
}

variable "faux_aws_region" {
  description = "The AWS region for this region is supposed to represent even though it will be created in the primary region of the deployment. (e.g us-east-1)"
}

variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
}

variable "kasm_db_ip" {
  description = "The IP/DINS name of the Kasm database"
}

variable "zone_name" {
  description = "A name given to the Kasm deployment Zone"
}

variable "aws_key_pair" {
  description = "The name of an aws keypair to use."
}

variable "ec2_ami" {
  description = "The AMI used for the EC2 nodes. Recommended Ubuntu 18.04 LTS."
}

variable "manager_token" {
  description = "The password for the database. No special characters"
}

variable "certificate_arn" {
  description = "The certificate ARN created in the primary region for use with all load balancers in the deployment."
}

variable "ssh_access_cidr" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
}

variable "webapp_subnet_id_1" {
  description = "One of two subnet IDs created to host webapps in the primary region"
}

variable "webapp_subnet_id_2" {
  description = "One of two subnet IDs created to host webapps in the primary region"
}

variable "agent_subnet_id" {
  description = "Subnet ID created for agents"
}

variable "primary_vpc_id" {
  description = "The VPC ID of the primary region"
}