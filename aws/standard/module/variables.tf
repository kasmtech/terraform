variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
  type        = string
}

variable "aws_domain_name" {
  description = "The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https"
  type        = string
}

variable "aws_key_pair" {
  description = "The name of an aws keypair to use."
  type        = string
}

variable "vpc_subnet_cidr" {
  description = "The subnet CIDR to use for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "num_webapps" {
  description = "The number of WebApp role servers to create in the deployment"
  type        = number
  default     = 2
}

variable "num_agents" {
  description = "The number of Agent Role Servers to create in the deployment"
  type        = number
  default     = 2
}

variable "num_guac_nodes" {
  description = "The number of Agent Role Servers to create in the deployment"
  type        = number
  default     = 2
}

variable "webapp_instance_type" {
  description = "The instance type for the webapps"
  type        = string
  default     = "t3.small"
}

variable "db_instance_type" {
  description = "The instance type for the Database"
  type        = string
  default     = "t3.small"
}

variable "agent_instance_type" {
  description = "The instance type for the Agents"
  type        = string
  default     = "t3.medium"
}

variable "guac_instance_type" {
  description = "The instance type for the Guacamole RDP nodes"
  type        = string
  default     = "t3.medium"
}

variable "ssh_access_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "web_access_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "aws_region" {
  description = "The AWS region for the deployment. (e.g us-east-1)"
  type        = string
}

variable "ec2_ami" {
  description = "The AMI used for the EC2 nodes. Recommended Ubuntu 20.04 LTS."
  type        = string
}

variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
  type        = string
}

variable "swap_size" {
  description = "The amount of swap (in MB) to configure inside the compute instances"
  type        = number
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
  description = "The service registration token value for Guac RDP servers to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true
}

variable "kasm_zone_name" {
  description = "A name given to the kasm deployment Zone"
  type        = string
  default     = "default"
}

variable "anywhere" {
  description = "Anywhere route subnet"
  type        = string
  default     = "0.0.0.0/0"

  validation {
    condition     = can(cidrhost(var.anywhere, 0))
    error_message = "Anywhere variable must be valid IPv4 CIDR - usually 0.0.0.0/0 for all default routes and default Security Group access."
  }
}
