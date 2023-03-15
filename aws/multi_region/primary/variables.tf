variable "aws_region" {
  description = "The AWS region for the deployment. (e.g us-east-1)"
  type        = string
}

variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
  type        = string
}

variable "vpc_subnet_cidr" {
  description = "The subnet CIDR to use for the Primary VPC"
  type        = string
}

variable "aws_domain_name" {
  description = "The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https"
  type        = string
}

variable "db_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm Database instances"
  type        = number
}

variable "db_instance_type" {
  description = "The instance type for the Database"
  type        = string
  default     = "t3.small"
}

variable "swap_size" {
  description = "The amount of swap (in MB) to configure inside the compute instances"
  type        = number
}

variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
  type        = string
}

variable "database_password" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true
}

variable "redis_password" {
  description = "The password for the Redis server. No special characters"
  type        = string
  sensitive   = true
}

variable "user_password" {
  description = "The standard (non administrator) user password. No special characters"
  type        = string
  sensitive   = true
}

variable "admin_password" {
  description = "The administrative user password. No special characters"
  type        = string
  sensitive   = true
}

variable "manager_token" {
  description = "The manager token value for Agents to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true
}

variable "service_registration_token" {
  description = "The guac token value for Guac RDP servers to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true
}

variable "zone_name" {
  description = "A name given to the kasm deployment Zone"
  type        = string
  default     = "default"
}

variable "aws_key_pair" {
  description = "The name of an aws keypair to use."
  type        = string
}

variable "ec2_ami" {
  description = "The AMI used for the EC2 nodes. Recommended Ubuntu 20.04 LTS."
  type        = string
}

variable "ssh_access_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
}

variable "web_access_cidrs" {
  description = "List of Networks in CIDR notation for IPs allowed to access the Kasm Web interface"
  type        = list(string)
}

variable "num_webapps" {
  description = "The number of WebApp role servers to create in the deployment"
  type        = number
}

variable "anywhere" {
  description = "Anywhere subnet for routing and load ingress from all IPs"
  type        = string
  default     = "0.0.0.0/0"
}
