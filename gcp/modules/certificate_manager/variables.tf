variable "domain_name" {
  description = "Kasm deployment domain name"
  type        = string
}

variable "dns_managed_zone_name" {
  description = "The name of the GCP DNS zone"
  type        = string
}

variable "certificate_name" {
  description = "Certificate name in Certificate manager. Must be globally unique."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{5,63}", var.certificate_name))
    error_message = "The certificate_name must be globally unique, and can only be between 5-63 characters consisting of only lower case letters, number, and dash (-)."
  }
}

variable "certificate_dns_authorization_name" {
  description = "The name of the DNS Authorization job in Certificate Manager"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{5,63}", var.certificate_dns_authorization_name))
    error_message = "The certificate_dns_authorization_name must be globally unique, and can only be between 5-63 characters consisting of only lower case letters, number, and dash (-)."
  }
}

variable "certificate_map_name" {
  description = "Certificate map name"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{5,63}", var.certificate_map_name))
    error_message = "The certificate_map_name must be globally unique, and can only be between 5-63 characters consisting of only lower case letters, number, and dash (-)."
  }
}

## Pre-set values
variable "certificate_description" {
  description = "Certificate description"
  type        = string
  default     = "Global Load Balancer SSL Certificate"
}

variable "certificate_dns_authorization_description" {
  description = "Description of the DNS Authorization job in Certificate Manager"
  type        = string
  default     = "Global Load Balancer certificate DNS authorization"
}

variable "certificate_map_description" {
  description = "Description of the certificate map"
  type        = string
  default     = "Global HTTPS Load Balancer Certificate Map"
}

variable "certificate_scope" {
  description = "GCP Certificate scope"
  type        = string
  default     = "DEFAULT"

  validation {
    condition     = contains(["DEFAULT", "EDGE_CACHE"], var.certificate_scope)
    error_message = "The certificate_scope variable can only be one of: DEFAULT or EDGE_CACHE."
  }
}

variable "create_wildcard" {
  description = "Add wildcard domain to certificate"
  type        = bool
  default     = true
}

variable "resource_labels" {
  description = "Labels to add to all created resources in this project"
  type        = map(any)
  default     = {}
}
