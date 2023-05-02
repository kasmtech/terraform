variable "aws_access_key" {
  description = "The AWS access key used for deployment"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^([A-Z0-9]{20})", var.aws_access_key))
    error_message = "The aws_access_key variable must be a valid AWS Access Key (e.g. AKIAJSIE27KKMHXI3BJQ)."
  }
}

variable "aws_secret_key" {
  description = "The AWS secret key used for deployment"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^([a-zA-Z0-9+\\/-]{40})", var.aws_secret_key))
    error_message = "The aws_secret_key variable must be a valid AWS Secret Key value (e.g. wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY)"
  }
}

variable "aws_region" {
  description = "The AWS Region used for deployment"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^([a-z]{2}-[a-z]{4,}-[\\d]{1})$", var.aws_region))
    error_message = "The aws_region must be a valid Amazon Web Services (AWS) Region name, e.g. us-east-1"
  }
}

variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
  type        = string

  validation {
    condition     = can(regex("^[a-z]{4,15}", var.project_name))
    error_message = "The project_name variable can only be one word between 4 and 15 lower-case letters since it is a seed value in multiple object names."
  }
}

variable "kasm_zone_name" {
  description = "A name given to the kasm deployment Zone"
  type        = string
  default     = "default"

  validation {
    condition     = can(regex("^[a-z0-9A-Z-_]{4,15}", var.kasm_zone_name))
    error_message = "The kasm_zone_name variable can only be one word between 4 and 15 characters consisting of letters, numbers, dash (-), and underscore (_)."
  }
}

variable "aws_domain_name" {
  description = "The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https"
  type        = string

  validation {
    condition     = can(regex("(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]", var.aws_domain_name))
    error_message = "There are invalid characters in the aws_domain_name - it must be a valid domain name."
  }
}

variable "aws_key_pair" {
  description = "The name of an aws keypair to use."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{4,15}", var.aws_key_pair))
    error_message = "The aws_key_pair variable contains invalid characters. Allowed values are between 4-15 characters consisting of letters, numbers, and dashes (-)."
  }
}

variable "vpc_subnet_cidr" {
  description = "The subnet CIDR to use for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_subnet_cidr, 0))
    error_message = "The VPC subnet must be valid IPv4 CIDR."
  }
}

variable "swap_size" {
  description = "The amount of swap (in MB) to configure inside the compute instances"
  type        = number

  validation {
    condition     = var.swap_size >= 1024 && var.swap_size <= 8192 && floor(var.swap_size) == var.swap_size
    error_message = "Swap size is the amount of disk space to use for Kasm in MB and must be an integer between 1024 and 8192."
  }
}

variable "webapp_instance_type" {
  description = "The instance type for the webapps"
  type        = string
  default     = "t3.small"

  validation {
    condition     = can(regex("^(([a-z-]{1,3})(\\d{1,2})?(\\w{1,4})?)\\.(nano|micro|small|medium|metal|large|(2|3|4|6|8|9|10|12|16|18|24|32|48|56|112)?xlarge)", var.webapp_instance_type))
    error_message = "Check the webapp_instance_type variable and ensure it is a valid AWS Instance type (https://aws.amazon.com/ec2/instance-types/)."
  }
}

variable "db_instance_type" {
  description = "The instance type for the Database"
  type        = string
  default     = "t3.small"

  validation {
    condition     = can(regex("^(([a-z-]{1,3})(\\d{1,2})?(\\w{1,4})?)\\.(nano|micro|small|medium|metal|large|(2|3|4|6|8|9|10|12|16|18|24|32|48|56|112)?xlarge)", var.db_instance_type))
    error_message = "Check the db_instance_type variable and ensure it is a valid AWS Instance type (https://aws.amazon.com/ec2/instance-types/)."
  }
}

variable "agent_instance_type" {
  description = "The instance type for the Agents"
  type        = string
  default     = "t3.medium"

  validation {
    condition     = can(regex("^(([a-z-]{1,3})(\\d{1,2})?(\\w{1,4})?)\\.(nano|micro|small|medium|metal|large|(2|3|4|6|8|9|10|12|16|18|24|32|48|56|112)?xlarge)", var.agent_instance_type))
    error_message = "Check the agent_instance_type variable and ensure it is a valid AWS Instance type (https://aws.amazon.com/ec2/instance-types/)."
  }
}

variable "guac_instance_type" {
  description = "The instance type for the Guacamole RDP nodes"
  type        = string
  default     = "t3.medium"

  validation {
    condition     = can(regex("^(([a-z-]{1,3})(\\d{1,2})?(\\w{1,4})?)\\.(nano|micro|small|medium|metal|large|(2|3|4|6|8|9|10|12|16|18|24|32|48|56|112)?xlarge)", var.guac_instance_type))
    error_message = "Check the guac_instance_type variable and ensure it is a valid AWS Instance type (https://aws.amazon.com/ec2/instance-types/)."
  }
}

variable "num_webapps" {
  description = "The number of WebApp role servers to create in the deployment"
  type        = number
  default     = 2

  validation {
    condition     = var.num_webapps >= 1 && var.num_webapps <= 3 && floor(var.num_webapps) == var.num_webapps
    error_message = "Acceptable number of webapps range between 1-3."
  }
}

variable "num_agents" {
  description = "The number of Agent Role Servers to create in the deployment"
  type        = number
  default     = 2

  validation {
    condition     = var.num_agents >= 0 && var.num_agents <= 100 && floor(var.num_agents) == var.num_agents
    error_message = "Acceptable number of Kasm Agents range between 0-100."
  }
}

variable "num_guac_nodes" {
  description = "The number of Agent Role Servers to create in the deployment"
  type        = number
  default     = 1

  validation {
    condition     = var.num_guac_nodes >= 0 && var.num_guac_nodes <= 100 && floor(var.num_guac_nodes) == var.num_guac_nodes
    error_message = "Acceptable number of Kasm Agents range between 0-100."
  }
}

variable "ssh_access_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition     = alltrue([for subnet in var.ssh_access_cidrs : can(cidrhost(subnet, 0))])
    error_message = "One of the subnets provided in the ssh_access_cidr variable is invalid."
  }
}

variable "web_access_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition     = alltrue([for subnet in var.web_access_cidrs : can(cidrhost(subnet, 0))])
    error_message = "One of the subnets provided in the load_balancer_public_access variable is invalid."
  }
}

variable "ec2_ami" {
  description = "The AMI used for the EC2 nodes. Recommended Ubuntu 20.04 LTS."
  type        = string

  validation {
    condition     = can(regex("^(ami-[a-f0-9]{17})", var.ec2_ami))
    error_message = "Please verify that your AMI is in the correct format for AWS (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html)."
  }
}

variable "database_password" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.database_password))
    error_message = "The Database Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "redis_password" {
  description = "The password for the Redis server. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.redis_password))
    error_message = "The Redis Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "user_password" {
  description = "The standard (non administrator) user password. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.user_password))
    error_message = "The User Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "admin_password" {
  description = "The administrative user password. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.admin_password))
    error_message = "The Admin password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "manager_token" {
  description = "The manager token value for Agents to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.manager_token))
    error_message = "The Manager Token should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "service_registration_token" {
  description = "The service registration token value for Guac RDP servers to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.service_registration_token))
    error_message = "The Service Registration Token should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

## Non-validated variables
variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
  type        = string
}

variable "aws_default_tags" {
  description = "Default tags to apply to all AWS resources for this deployment"
  type        = map(any)
  default = {
    Service_name = "Kasm Workspaces"
    Kasm_version = "1.12"
  }
}
