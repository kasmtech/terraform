variable "digital_ocean_token" {
  description = "Authentication Token For Digital Ocean"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^(dop_v1_[a-f0-9]{64})", var.digital_ocean_token))
    error_message = "The digital_ocean_token must be a valid API Token (https://docs.digitalocean.com/reference/api/create-personal-access-token/)."
  }
}

variable "digital_ocean_region" {
  description = "The Digital Ocean region where you wish to deploy Kasm"
  type        = string
  default     = "nyc3"

  validation {
    condition     = can(regex("^[a-zA-Z]{3}\\d", var.digital_ocean_region))
    error_message = "The DigitalOcean region format is always 3 letters and a number (e.g. nyc3) - check out https://docs.digitalocean.com/products/platform/availability-matrix/ for available regions."
  }
}

variable "do_domain_name" {
  description = "The domain name that users will use to access Kasm"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9_-]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,6}", var.do_domain_name))
    error_message = "There are invalid characters in the do_domain_name - it must be a valid domain name."
  }
}

variable "ssh_key_fingerprints" {
  # The ssh key fingerprints from uploaded keys can be obtained at https://cloud.digitalocean.com/account/security
  description = "Keys used for sshing into kasm hosts"
  type        = list(string)

  validation {
    condition     = alltrue([for fingerprint in var.ssh_key_fingerprints : can(regex("^([a-f0-9]{2}:?){16}$", fingerprint))])
    error_message = "One of the SSH Key fingerprints is incorrectly formatted. It should be 16 colon-delimited hex bytes (e.g. 12:34:56:78:90:ab:cd:ef:12:34:56:78:90:ab:cd:ef)."
  }
}

variable "project_name" {
  description = "The name of the project/deployment/company eg (acme)."
  type        = string

  validation {
    condition     = can(regex("^[a-z]{1,15}", var.project_name))
    error_message = "The project_name variable can only be one word between 1 and 15 lower-case letters since it is a seed value in multiple object names."
  }
}

variable "vpc_subnet_cidr" {
  description = "VPC Subnet CIDR where you wish to deploy Kasm"
  type        = string
  default     = "10.0.0.0/24"

  validation {
    condition     = can(cidrhost(var.vpc_subnet_cidr, 0))
    error_message = "The vpc_subnet_cidr must be a valid IPv4 Subnet in CIDR notation (e.g. 10.0.0.0/24)"
  }
}

variable "digital_ocean_droplet_slug" {
  description = "The Default Digital Ocean Droplet Slug: https://slugs.do-api.dev/"
  type        = string
  default     = "s-2vcpu-4gb-intel"
}

variable "digital_ocean_image" {
  description = "Default Image for Ubuntu 20.04 LTS with Docker"
  type        = string
  default     = "docker-20-04"
}

variable "kasm_build_url" {
  description = "The Kasm build file to install"
  type        = string
  default     = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.12.0.d4fd8a.tar.gz"
}

variable "user_password" {
  description = "The default password to be used for the default user@kasm.local account. Only use alphanumeric characters"
  type        = string
  default     = "changeme"

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.user_password))
    error_message = "The User Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "admin_password" {
  description = "The default password to be used for the default admin@kasm.local account. Only use alphanumeric characters"
  default     = "changeme"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.admin_password))
    error_message = "The Admin Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "allow_ssh_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition     = alltrue([for subnet in var.allow_ssh_cidrs : can(cidrhost(subnet, 0))])
    error_message = "One of the subnets provided in the allow_ssh_cidrs list is invalid."
  }
}

variable "allow_kasm_web_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition     = alltrue([for subnet in var.allow_kasm_web_cidrs : can(cidrhost(subnet, 0))])
    error_message = "One of the subnets provided in the allow_ssh_cidrs list is invalid."
  }
}

variable "swap_size" {
  description = "The amount of swap (in GB) to configure inside the compute instances"
  type        = number

  validation {
    condition     = var.swap_size >= 1 && var.swap_size <= 8 && floor(var.swap_size) == var.swap_size
    error_message = "Swap size is the amount of disk space to use for Kasm in GB and must be an integer between 1 and 8."
  }
}
