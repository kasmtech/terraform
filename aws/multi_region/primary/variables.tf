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
  description = "The service registration token value for cpx RDP servers to authenticate to webapps. No special characters"
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
  description = "The AMI used for the EC2 nodes. Recommended Ubuntu 22.04 LTS."
  type        = string
}

variable "web_access_cidrs" {
  description = "List of Networks in CIDR notation for IPs allowed to access the Kasm Web interface"
  type        = list(string)
}

variable "num_webapps" {
  description = "The number of WebApp role servers to create in the deployment"
  type        = number
}

variable "num_cpx_nodes" {
  description = "The number of cpx RDP role servers to create in the deployment"
  type        = number
}

variable "create_aws_ssm_iam_role" {
  description = "Create an AWS SSM IAM role to attach to VMs for SSH/console access to VMs."
  type        = bool
  default     = false
}

variable "aws_ssm_iam_role_name" {
  description = "The name of the SSM EC2 role to associate with Kasm VMs for SSH access"
  type        = string
  default     = ""
}

variable "aws_ssm_instance_profile_name" {
  description = "The name of the SSM EC2 Instance Profile to associate with Kasm VMs for SSH access"
  type        = string
  default     = ""
}

variable "anywhere" {
  description = "Anywhere subnet for routing and load ingress from all IPs"
  type        = string
  default     = "0.0.0.0/0"
}

variable "public_lb_security_rules" {
  description = "A map of objects of security rules to apply to the Public ALB"
  type = map(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))

  default = {
    https = {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
    }
    http = {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
    }
  }
}

variable "webapp_security_rules" {
  description = "A map of objects of security rules to apply to the Kasm WebApp server"
  type = map(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))

  default = {
    https = {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
    }
  }
}

variable "db_security_rules" {
  description = "A map of objects of security rules to apply to the Kasm DB"
  type = map(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))

  default = {
    postgres = {
      from_port = 5432
      to_port   = 5432
      protocol  = "tcp"
    }
    redis = {
      from_port = 6379
      to_port   = 6379
      protocol  = "tcp"
    }
  }
}

variable "cpx_security_rules" {
  description = "A map of objects of security rules to apply to the Kasm Connection Proxy server"
  type = map(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))

  default = {
    https = {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
    }
  }
}

variable "agent_security_rules" {
  description = "A map of objects of security rules to apply to the Kasm WebApp server"
  type = map(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))

  default = {
    https = {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
    }
  }
}

variable "windows_security_rules" {
  description = "A map of objects of security rules to apply to the Kasm Windows VMs"
  type = map(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))

  default = {
    cpx_rdp = {
      from_port = 3389
      to_port   = 3389
      protocol  = "tcp"
    }
    cpx_api = {
      from_port = 4902
      to_port   = 4902
      protocol  = "tcp"
    }
    webapp_api = {
      from_port = 4902
      to_port   = 4902
      protocol  = "tcp"
    }
  }
}

variable "default_egress" {
  description = "Default egress security rule for all security groups"
  type = map(object({
    from_port    = number
    to_port      = number
    protocol     = string
    cidr_subnets = list(string)
  }))

  default = {
    all = {
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      cidr_subnets = ["0.0.0.0/0"]
    }
  }
}
