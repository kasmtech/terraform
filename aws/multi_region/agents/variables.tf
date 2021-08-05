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

variable "num_agents" {
  description = "The number of Agent Role Servers to create in the deployment"
}

variable "agent_instance_type" {
  description = "the instance type for the agents"
}

variable "aws_region" {
  description = "The AWS region for the deployment. (e.g us-east-1)"
}

variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
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

variable "ssh_access_cidr" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
}
