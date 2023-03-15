variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
  type        = string
}

variable "aws_domain_name" {
  description = "The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https"
  type        = string
}

variable "webapp_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm WebApp instances"
  type        = number
}

variable "agent_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm Agent instances"
  type        = number
  default     = 0
}

variable "database_password" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true
}

variable "redis_password" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true
}

variable "manager_token" {
  description = "The Manager Token used by Kasm Agents to authenticate. No special characters"
  type        = string
  sensitive   = true
}

variable "swap_size" {
  description = "The amount of swap (in MB) to configure inside the compute instances"
  type        = number
}

variable "num_webapps" {
  description = "The number of WebApp role servers to create in the deployment"
  type        = number
  default     = 2
}

variable "webapp_instance_type" {
  description = "The instance type for the webapps"
  type        = string
  default     = "t3.small"
}

variable "webapp_security_group_id" {
  description = "WebApp security group ID"
  type        = string
}

variable "webapp_subnet_ids" {
  description = "WebApp subnet IDs created to host webapps in the primary region"
  type        = list(string)
}

variable "num_agents" {
  description = "The number of Agent Role Servers to create in the deployment"
  type        = number
  default     = 0
}

variable "agent_instance_type" {
  description = "the instance type for the agents"
  type        = string
  default     = "t3.medium"
}

variable "agent_subnet_id" {
  description = "Subnet ID created for agents"
  type        = string
  default     = ""
}

variable "agent_security_group_id" {
  description = "Kasm Agent security group ID"
  type        = string
  default     = ""
}

variable "primary_aws_region" {
  description = "The AWS region for primary region of the deployment. (e.g us-east-1)"
  type        = string
}

variable "faux_aws_region" {
  description = "The AWS region this WebApp is supposed to represent even though it will be created in the primary region of the deployment. (e.g us-east-1)"
  type        = string
}

variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
  type        = string
}

variable "kasm_db_ip" {
  description = "The IP/DNS name of the Kasm database"
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

variable "certificate_arn" {
  description = "The certificate ARN created in the primary region for use with all load balancers in the deployment."
  type        = string
}

variable "ssh_access_cidrs" {
  description = "List of Networks in CIDR notation for IPs allowed to SSH in to the machines"
  type        = list(string)
}

variable "load_balancer_log_bucket" {
  description = "S3 bucket name for load balancers to forward access logs to"
  type        = string
}

variable "primary_vpc_id" {
  description = "The VPC ID of the primary region"
  type        = string
}

variable "load_balancer_security_group_id" {
  description = "Security Group ID for the Primary region's load balancer"
  type        = string
}
