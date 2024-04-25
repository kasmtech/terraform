variable "project_id" {
  description = "Project id for the zone."
  type        = string
}

variable "account_id" {
  description = "The account id used to generate the service account email address"
  type        = string

  validation {
    condition     = can(regex("^([a-z]([-a-z0-9]*[a-z0-9]){6,30})", var.account_id))
    error_message = "The account_id must be between 6-30 characters beginning with a lower case letter, and consisting of lower case letters, numbers, or dash (-)."
  }
}

## Pre-set values
variable "display_name" {
  description = "The service account display name"
  type        = string
  default     = ""
}

variable "dns_public_zone_name" {
  description = "Friendly name of the public DNS zone to manage. Only used if Direct to Agent is enabled."
  type        = string
  default     = ""
}

variable "manage_dns" {
  description = "Allow the service account to add/delete DNS records for direct-to-agent."
  type        = bool
  default     = false
}
