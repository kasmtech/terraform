variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
  type        = string
}

variable "oci_domain_name" {
  description = "The public Zone used for the dns entries. This must already exist in the OCI account. (e.g kasm.contoso.com). The deployment will be accessed via this zone name via https"
  type        = string
}

variable "tenancy_ocid" {
  description = "The Tenancy OCID."
  type        = string
}

variable "compartment_ocid" {
  description = "The Compartment OCID"
  type        = string
}

variable "region" {
  description = "The OCI Region eg: (us-ashburn-1)"
  type        = string
}

variable "user_ocid" {
  description = "The User OCID."
  type        = string
}

variable "fingerprint" {
  description = "API Key Fingerprint"
  type        = string
}

variable "private_key_path" {
  description = "The path to the API Key PEM encoded Private Key"
  type        = string
  sensitive   = true
}

variable "letsencrypt_cert_support_email" {
  description = "Email address to use for Let's Encrypt SSL certificates for OCI Deployment"
  type        = string
}
variable "letsencrypt_server_type" {
  description = "SSL Server type to generate. Valid options are staging, prod, and empty string. Prod certificates are limited to 5 per week per domain."
  type        = string
}

variable "vcn_subnet_cidr" {
  description = "VPC Subnet CIDR where you wish to deploy Kasm"
  type        = string
}

variable "ssh_authorized_keys" {
  description = "The SSH Public Keys to be installed on the OCI compute instance"
  type        = string
}

variable "instance_image_ocid" {
  description = "The OCID for the instance image , such as ubuntu 20.04, to use."
  type        = string
}

variable "allow_ssh_cidrs" {
  description = "The CIDR notation to allow SSH access to the systems."
  type        = list(string)
}

variable "allow_web_cidrs" {
  description = "The CIDR notation to allow HTTPS access to the systems."
  type        = list(string)
}

variable "kasm_ssl_crt_path" {
  description = "The file path to the PEM encoded SSL Certificate"
  type        = string
}

variable "kasm_ssl_key_path" {
  description = "The file path to the PEM encoded SSL Certificate Key"
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

variable "kasm_build_url" {
  description = "The URL for the Kasm Workspaces build"
  type        = string
}

variable "swap_size" {
  description = "The amount of swap (in GB) to configure inside the compute instances"
  type        = number
}

variable "instance_shape" {
  description = "The instance shape to use. Should be a Flex type."
  type        = string
}

variable "kasm_server_cpus" {
  description = "The number of CPUs to configure for the Kasm instance"
  type        = number
}

variable "kasm_server_memory" {
  description = "The amount of memory to configure for the Kasm instance"
  type        = number
}

variable "kasm_server_hdd_size" {
  description = "The size in GBs of the Kasm instance HDD"
  type        = number
}

## Pre-set values
variable "anywhere" {
  description = "Anywhere route subnet"
  type        = string
  default     = "0.0.0.0/0"

  validation {
    condition     = can(cidrhost(var.anywhere, 0))
    error_message = "Anywhere variable must be valid IPv4 CIDR - usually 0.0.0.0/0 for all default routes and default Security Group access."
  }
}
