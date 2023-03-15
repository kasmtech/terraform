variable "project_name" {
  description = "The name of the project/deployment/company eg (acme). Lower case all one word as this will be used in a domain name"
  type        = string
}

variable "digital_ocean_region" {
  description = "The Default Digital Ocean Region Slug: https://docs.digitalocean.com/products/platform/availability-matrix/"
  type        = string
}

variable "digital_ocean_droplet_slug" {
  description = "The Default Digital Ocean Droplet Slug: https://slugs.do-api.dev/"
  type        = string
}

variable "digital_ocean_image" {
  description = "Default Image for Ubuntu LTS"
  type        = string
}

variable "vpc_subnet_cidr" {
  description = "VPC Subnet CIDR to deploy Kasm"
  type        = string
}

variable "kasm_build_url" {
  description = "The Kasm build file to install"
  type        = string
}

variable "user_password" {
  description = "The default password to be used for the default user@kasm.local account. Only use alphanumeric characters"
  type        = string
  sensitive   = true
}

variable "admin_password" {
  description = "The default password to be used for the default admin@kasm.local account. Only use alphanumeric characters"
  type        = string
  sensitive   = true
}

variable "allow_ssh_cidrs" {
  description = "List of Subnets in CIDR notation for hosts allowed to SSH"
  type        = list(string)
}

variable "allow_kasm_web_cidrs" {
  description = "CIDR notation of the bastion host allowed to SSH in to the machines"
  type        = list(string)
}

variable "do_domain_name" {
  description = "The domain name that users will use to access kasm"
  type        = string
}

variable "ssh_key_fingerprints" {
  # The ssh key fingerprints from uploaded keys can be obtained at https://cloud.digitalocean.com/account/security
  description = "Keys used for sshing into kasm hosts"
  type        = list(string)
}

variable "swap_size" {
  description = "The amount of swap (in MB) to configure inside the compute instances"
  type        = number

  validation {
    condition     = var.swap_size >= 1024 && var.swap_size <= 8192 && floor(var.swap_size) == var.swap_size
    error_message = "Swap size is the amount of disk space to use for Kasm in MB and must be an integer between 1024 and 8192."
  }
}

variable "anywhere" {
  description = "Anywhere route subnet"
  type        = list(string)
  default     = ["0.0.0.0/0", "::/0"]

  validation {
    condition     = can([for subnet in var.anywhere : cidrhost(subnet, 0)])
    error_message = "Anywhere variable must be valid IPv4 CIDR - usually 0.0.0.0/0 for all default routes and default Security Group access."
  }
}
