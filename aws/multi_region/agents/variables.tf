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

variable "num_cpx_nodes" {
  description = "The number of cpx  Role Servers to create in the deployment"
  type        = number
}

variable "cpx_instance_type" {
  description = "The instance type for the cpx RDP nodes"
  type        = string
}

variable "cpx_hdd_size_gb" {
  description = "The HDD size for Kasm Guac RDP nodes"
  type        = number
}

variable "aws_ssm_iam_role_name" {
  description = "The name of the SSM EC2 role to associate with Kasm VMs for SSH access"
  type        = string
  default     = ""
}

variable "num_proxy_nodes" {
  description = "The number of Dedicated Proxy nodes to create in the deployment"
  type        = number
  default     = 2
}

variable "proxy_instance_type" {
  description = "The instance type for the dedicated proxy nodes"
  type        = number
}

variable "proxy_hdd_size_gb" {
  description = "The HDD size for Dedicated Proxy nodes"
  type        = number
}

variable "aws_region" {
  description = "The AWS region for the deployment. (e.g us-east-1)"
  type        = string
}

variable "load_balancer_log_bucket" {
  description = "S3 bucket name for load balancers to forward access logs to"
  type        = string
}

variable "kasm_build" {
  description = "The URL for the Kasm Workspaces build"
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

variable "service_registration_token" {
  description = "The service registration token value for cpx RDP servers to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true
}

variable "management_region_nat_gateway" {
  description = "A list Kasm management region NAT gateways to allow Webapps ingress on 4902 to Kasm Windows agent"
  type        = string
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

variable "proxy_security_rules" {
  description = "A map of objects of security rules to apply to the Kasm WebApp server"
  type = object({
    from_port = number
    to_port   = number
    protocol  = string
  })

  default = {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
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
    rdp = {
      from_port = 3389
      to_port   = 3389
      protocol  = "tcp"
    }
    api = {
      from_port = 4902
      to_port   = 4902
      protocol  = "tcp"
    }
  }
}

variable "default_egress" {
  description = "Default egress security rule for all security groups"
  type = object({
    from_port    = number
    to_port      = number
    protocol     = string
    cidr_subnets = list(string)
  })

  default = {
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_subnets = ["0.0.0.0/0"]
  }
}
