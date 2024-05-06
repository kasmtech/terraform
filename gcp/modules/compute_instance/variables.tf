variable "instance_details" {
  description = "Instance details to configure for Kasm instance"
  type = object({
    machine_type     = string
    disk_size_gb     = number
    instance_role    = string
    name             = optional(string, "")
    name_prefix      = optional(string, "")
    disk_auto_delete = optional(bool, true)
    description      = optional(string, null)
    disk_type        = optional(string, "pd-balanced")
  })

  validation {
    condition     = contains(["database", "webapp", "agent", "cpx"], var.instance_details.instance_role)
    error_message = "The instance_details name attribute can only be a max of 63 characters consisting of lower case letters, numbers, and dash (-)."
  }
  validation {
    condition     = var.instance_details.name == "" ? true : can(regex("^[a-z0-9-]{4,63}", var.instance_details.name))
    error_message = "The instance_details name attribute can only be a max of 63 characters consisting of lower case letters, numbers, and dash (-)."
  }
  validation {
    condition     = var.instance_details.name_prefix == "" ? true : can(regex("^[a-z0-9-]{4,63}", var.instance_details.name_prefix))
    error_message = "The instance_details name_prefix attribute can only be a max of 63 characters consisting of lower case letters, numbers, and dash (-)."
  }
  validation {
    condition     = var.instance_details.disk_size_gb > 30
    error_message = "The instance_details disk_size_gb should be larger than 30GB to support Kasm, logging, and other required services. Recommended minimum size is 50GB."
  }
  validation {
    condition     = contains(["pd-standard", "pd-balanced", "pd-ssd", "pd-extreme"], var.instance_details.disk_type)
    error_message = "The disk_type can only be one of pd-standard, pd-balanced, pd-extreme, or pd-ssd. Refer to https://cloud.google.com/compute/docs/disks for more details."
  }
}

variable "kasm_region" {
  description = "GCP region in which to deploy this Kasm instance"
  type        = string
}

variable "security_tags" {
  description = "Security tags to use with firewall rules to allow instance access"
  type        = list(string)
}

variable "cloud_init_script" {
  description = "Startup script used to provision the instance"
  type        = list(string)
}

variable "instance_subnetwork" {
  description = "Name of subnetwork where to deploy the instance"
  type        = string
}

variable "source_image" {
  description = "The source VM Image information to use for deploying Kasm. Recommended to use Ubuntu 20.04 Minimal. You can either explicitly define the source image to use, or the image project and family so that Terraform always chooses the latest."
  type = list(object({
    source_image = optional(string, null)
    project      = optional(string, null)
    family       = optional(string, null)
  }))
}

## Pre-set values
variable "number_of_instances" {
  description = "Number of instances to deploy in this region"
  type        = number
  default     = 1
}

variable "instance_network" {
  description = "VPC Network self_link where instance is to be deployed. Usually inferred by the subnetwork, however, if subnetwork names overlap, this can create confusion. This value is optional, and required if subnetwork names are reused across VPCs."
  type        = string
  default     = null
}

variable "allow_stopping_for_update" {
  description = "Allow GCP service accounts to stop the instance and initiate an updates"
  type        = bool
  default     = false
}

variable "instance_delete_protection" {
  description = "Prevent instance from accidental deletion"
  type        = bool
  default     = true
}

variable "instance_nic_type" {
  description = "The default network interface type"
  type        = string
  default     = "GVNIC"

  validation {
    condition     = contains(["GVNIC", "VIRTIO_NET"], var.instance_nic_type)
    error_message = "The instance_nic_type can only be one of GVNIC or VIRTIO_NET. GVNIC currently offers enhanced performance and capabilities. Refer to this document (https://cloud.google.com/compute/docs/networking/using-gvnic) for more information."
  }
}

variable "instance_nic_stack_type" {
  description = "The default network interface type"
  type        = string
  default     = "IPV4_ONLY"

  validation {
    condition     = contains(["IPV4_ONLY", "IPV4_IPV6"], var.instance_nic_stack_type)
    error_message = "The instance_nic_stack_type can only be one of IPV4_ONLY or IPV4_IPV6. Kasm recommends IPV4_ONLY since IPv6 is supported, but it requires additional, custom configuration by the administrator. Only enable IPv6 if you know what you are doing. Refer to this write up for more information: https://www.reddit.com/r/kasmweb/comments/sg6tv9/guide_enabling_ipv6_on_your_kasmweb_server/."
  }
}

variable "enable_secure_boot" {
  description = "Enable instance secure boot"
  type        = bool
  default     = null
}

variable "enable_instance_vtpm" {
  description = "Enable the Trusted Platform Module to secure the instance"
  type        = bool
  default     = true
}

variable "enable_integrity_monitoring" {
  description = "Enable instance integrity monitoring"
  type        = bool
  default     = true
}

variable "public_access_config" {
  description = "Enable public IP access for instance"
  type = list(object({
    nat_ip                 = optional(string)
    public_ptr_domain_name = optional(string)
    network_tier           = optional(string)
  }))
}

variable "service_account" {
  description = "Service account to use for instance auto updates"
  type = list(object({
    email  = optional(string)
    scopes = list(string)
  }))
  default = []
}

variable "resource_labels" {
  description = "Labels to apply to the instance"
  type        = map(any)
  default     = null
}
