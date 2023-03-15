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

variable "aws_key_pair" {
  description = "The name of an aws keypair to use."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{4,15}", var.aws_key_pair))
    error_message = "The aws_key_pair variable contains invalid characters. Allowed values are between 4-15 characters consisting of letters, numbers, and dashes (-)."
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

variable "aws_domain_name" {
  description = "The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https"
  type        = string

  validation {
    condition     = can(regex("(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]", var.aws_domain_name))
    error_message = "There are invalid characters in the aws_domain_name - it must be a valid domain name."
  }
}

variable "primary_vpc_subnet_cidr" {
  description = "The subnet CIDR to use for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.primary_vpc_subnet_cidr, 0))
    error_message = "The VPC subnet must be valid IPv4 CIDR."
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

variable "num_webapps" {
  description = "The number of WebApp role servers to create in the deployment"
  type        = number
  default     = 2

  validation {
    condition     = var.num_webapps >= 1 && var.num_webapps <= 3 && floor(var.num_webapps) == var.num_webapps
    error_message = "Acceptable number of webapps range between 1-3."
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

variable "webapp_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm WebApp instances"
  type        = number

  validation {
    condition     = can(var.webapp_hdd_size_gb >= 40)
    error_message = "Kasm Webapps should have at least a 40 GB HDD to ensure enough space for Kasm services."
  }
}

variable "db_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm Database instances"
  type        = number

  validation {
    condition     = can(var.db_hdd_size_gb >= 40)
    error_message = "Kasm Database should have at least a 40 GB HDD to ensure enough space for Kasm services."
  }
}

variable "agent_hdd_size_gb" {
  description = "The HDD size in GB to configure for the Kasm Agent instances"
  type        = number

  validation {
    condition     = can(var.agent_hdd_size_gb >= 120)
    error_message = "Kasm Agents should have at least a 120 GB HDD to ensure enough space for Kasm services."
  }
}

variable "primary_region_ec2_ami_id" {
  description = "AMI Id of Kasm EC2 image in the primary region. Recommended AMI OS Version is Ubuntu 20.04 LTS."
  type        = string
  default     = "ami-09cd747c78a9add63"

  validation {
    condition     = can(regex("^(ami-[a-f0-9]{17})", var.primary_region_ec2_ami_id))
    error_message = "Please verify that your AMI is in the correct format for AWS (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html)."
  }
}

variable "secondary_regions_settings" {
  description = "Map of Kasm settings for secondary regions"
  type        = map(any)

  validation {
    condition     = can([for region in var.secondary_regions_settings : regex("^([a-z]{2}-[a-z]{4,}-[\\d]{1})$", region.agent_region)])
    error_message = "Verify the regions in the secondary_regions_settings variable and ensure they are valid AWS regions in a valid format (e.g. us-east-1)."
  }
  validation {
    condition     = can([for ami_id in var.secondary_regions_settings : regex("^(ami-[a-f0-9]{17})", ami_id.agent_ec2_ami_id)])
    error_message = "Please verify that all of your Region's AMI IDs are in the correct format for AWS (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html)."
  }
  validation {
    condition     = can([for instance_type in var.secondary_regions_settings : regex("^(([a-z-]{1,3})(\\d{1,2})?(\\w{1,4})?)\\.(nano|micro|small|medium|metal|large|(2|3|4|6|8|9|10|12|16|18|24|32|48|56|112)?xlarge)", instance_type.agent_instance_type)])
    error_message = "Check the Instance types used in your secondary_regions_settings and ensure they are valid AWS Instance types (https://aws.amazon.com/ec2/instance-types/)."
  }
  validation {
    condition     = can([for number_of_agents in var.secondary_regions_settings : number_of_agents.num_agents >= 0 && number_of_agents.num_agents <= 100 && floor(number_of_agents.num_agents) == number_of_agents.num_agents])
    error_message = "Check the number of agents in the secondary_regions_settings variable. Acceptable number of Kasm Agents range between 0-100."
  }
  validation {
    condition     = can([for subnet in var.secondary_regions_settings : cidrhost(subnet.agent_vpc_cidr, 0)])
    error_message = "Verify the VPC subnet in your secondary_regions_settings. They must all be valid IPv4 CIDRs."
  }
}

variable "aws_primary_region" {
  description = "The AWS Region used for deployment"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^([a-z]{2}-[a-z]{4,}-[\\d]{1})$", var.aws_primary_region))
    error_message = "The aws_primary_region must be a valid Amazon Web Services (AWS) Region name, e.g. us-east-1"
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

variable "database_password" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.database_password))
    error_message = "The Database Password should be a string between 12 and 30 letters and numbers with no special characters."
  }
}

variable "redis_password" {
  description = "The password for the Redis server. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.redis_password))
    error_message = "The Redis Password should be a string between 12 and 30 letters and numbers with no special characters."
  }
}

variable "user_password" {
  description = "The standard (non administrator) user password. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.user_password))
    error_message = "The User Password should be a string between 12 and 30 letters and numbers with no special characters."
  }
}

variable "admin_password" {
  description = "The administrative user password. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.admin_password))
    error_message = "The Admin password should be a string between 12 and 30 letters and numbers with no special characters."
  }
}

variable "manager_token" {
  description = "The manager token value for Agents to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.manager_token))
    error_message = "The Manager Token should be a string between 12 and 30 letters and numbers with no special characters."
  }
}

variable "ssh_access_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition     = can([for subnet in var.ssh_access_cidrs : cidrhost(subnet, 0)])
    error_message = "One of the subnets provided in the ssh_access_cidr variable is invalid."
  }
}

variable "web_access_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition     = can([for subnet in var.web_access_cidrs : cidrhost(subnet, 0)])
    error_message = "One of the subnets provided in the web_access_cidrs variable is invalid."
  }
}

## Non-validated variables
variable "kasm_build" {
  description = "Download URL for Kasm Workspaces"
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
