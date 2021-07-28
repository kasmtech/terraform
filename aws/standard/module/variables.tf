variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
}

variable "aws_domain_name" {
  description = "The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https"
}

variable "aws_key_pair" {
  description = "The name of an aws keypair to use."
}

variable "aws_access_key" {
  description = "The AWS access key used for deployment"
}

variable "aws_secret_key" {
  description = "The AWS secret key used for deployment"
}

variable "num_agents" {
  default     = "2"
  description = "The number of Agent Role Servers to create in the deployment"
}

variable "agent_instance_type" {
  default     = "t3.medium"
  description = "The instance type for the Agents"
}


variable "num_webapps" {
  default     = "2"
  description = "The number of WebApp role servers to create in the deployment"
}

variable "webapp_instance_type" {
  default     = "t3.small"
  description = "The instance type for the Agents"
}


variable "db_instance_type" {
  default     = "t3.small"
  description = "The instance type for the Database"
}

variable "ssh_access_cidr" {
  default     = "0.0.0.0/0"
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
}

variable "aws_region" {
  default = "us-east-1"
  description = "The AWS region for the deployment. (e.g us-east-1)"
}
variable "ec2_ami" {
  default     = "ami-0747bdcabd34c712a"
  description = "The AMI used for the EC2 nodes. Recommended Ubuntu 18.04 LTS."
}

variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
}

variable "s3_unique_id" {
  default     = "4id0"
  description = "A unique id to give to the S3 buckets so they are globally unique"
}

variable "master_subnet_id" {
  default     = "0"
  description = "The 2nd octect of VPC subnet"
}

variable "database_password" {
  description = "The password for the database. No special characters"
}
variable "redis_password" {
  description = "The password for the database. No special characters"
}
variable "user_password" {
  description = "The password for the database. No special characters"
}
variable "admin_password" {
  description = "The password for the database. No special characters"
}
variable "manager_token" {
  description = "The password for the database. No special characters"
}
variable "zone_name" {
  default = "default"
  description="A name given to the kasm deployment Zone"
}
