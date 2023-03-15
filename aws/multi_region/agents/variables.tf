variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
  type        = string
}

variable "aws_domain_name" {
  description = "The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https"
  type        = string
}

variable "agent_vpc_cidr" {
  description = "Subnet CIDR range for Agent VPC"
  type        = string
}

variable "swap_size" {
  description = "The amount of swap (in MB) to configure inside the compute instances"
  type        = number
}

variable "num_agents" {
  description = "The number of Agent Role Servers to create in the deployment"
  type        = number
}

variable "agent_instance_type" {
  description = "The instance type for the agents"
  type        = string
}

variable "agent_hdd_size_gb" {
  description = "The HDD size for agents"
  type        = number
}

variable "aws_region" {
  description = "The AWS region for the deployment. (e.g us-east-1)"
  type        = string
}

variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
  type        = string
}

variable "zone_name" {
  description = "A name given to the Kasm deployment Zone"
  type        = string
}

variable "aws_key_pair" {
  description = "The name of an aws keypair to use."
  type        = string
}

variable "ec2_ami" {
  description = "The AMI used for the EC2 nodes. Recommended Ubuntu 20.04 LTS."
  type        = string
}

variable "manager_token" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true
}

variable "ssh_access_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
}

variable "anywhere" {
  description = "Anywhere subnet for routing and load ingress from all IPs"
  type        = string
  default     = "0.0.0.0/0"
}
