## Connection variables
variable "project_id" {
  description = "GCP Project ID where to deploy Kasm"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]", var.project_id))
    error_message = "The project_id variable should be a valid GCP Project ID and can only consist of lower case letters, numbers, and dash (-)."
  }
}

variable "google_credential_file_path" {
  description = "File path to GCP account authentication file"
  type        = string
  default     = ""

  validation {
    condition     = var.google_credential_file_path == "" ? true : fileexists(var.google_credential_file_path)
    error_message = "The variable google_credential_file_path must point to a valid GCP credential file."
  }
  validation {
    condition     = var.google_credential_file_path == "" ? true : !can(regex("replaceme", file(var.google_credential_file_path)))
    error_message = "You must add valid GCP credentials in JSON format in the google_credential_file_path file."
  }
}

## Network variables
variable "vpc_name" {
  description = "Name for Kasm VPC"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,63}", var.vpc_name))
    error_message = "The vpc_name variable can only be a max of 63 characters beginning with a lower case letter, and consisting of lower case letters, numbers, and dash (-)."
  }
}

variable "kasm_vpc_subnet" {
  description = "VPC Subnet CIDR range. All other Subnets will be automatically calculated from this seed value."
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.kasm_vpc_subnet, 0))
    error_message = "The kasm_vpc_subnet variable must be a valid IPv4 CIDR Subnet in the format x.x.x.x/x, and the default is 10.0.0.0/16."
  }
}

variable "kasm_deployment_regions" {
  description = "Kasm regions to deploy into"
  type        = list(string)
}

## Kasm variables
variable "kasm_download_url" {
  description = "Download URL for Kasm Workspaces installer"
  type        = string
}

variable "kasm_domain_name" {
  description = "Public DNS domain name to use for Kasm deployment"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,6}", var.kasm_domain_name))
    error_message = "There are invalid characters in the kasm_domain_name - it must be a valid domain name."
  }
}

variable "kasm_project_name" {
  description = "Kasm deployment project name (separate from GCP Project id or Project Name)"
  type        = string
  default     = ""

  validation {
    condition     = var.kasm_project_name == "" ? true : can(regex("^[a-z0-9-]{2,25}", var.kasm_project_name))
    error_message = "The kasm_project_name is used in labels and "
  }
}

variable "deployment_type" {
  description = "The deployment type - Single-Server, Multi-Server, or Multi-Region"
  type        = string
  default     = "Multi-Server"

  validation {
    condition     = contains(["Single-Server", "Multi-Server", "Multi-Region", ""], var.deployment_type)
    error_message = "The deployment_type variable declares the deployment type and can only consisit of one of the values Single-Server, Multi-Server, or Multi-Region."
  }
}

variable "kasm_version" {
  description = "Kasm version to deploy"
  type        = string
  default     = ""
}

variable "kasm_database_password" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = var.kasm_database_password == "" ? true : can(regex("^[a-zA-Z0-9]{12,40}", var.kasm_database_password))
    error_message = "The Kasm Database should be a string between 12 and 40 letters or numbers with no special characters."
  }
}

variable "kasm_redis_password" {
  description = "The password for the Redis server. No special characters"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = var.kasm_redis_password == "" ? true : can(regex("^[a-zA-Z0-9]{12,40}", var.kasm_redis_password))
    error_message = "The Kasm Redis should be a string between 12 and 40 letters or numbers with no special characters."
  }
}

variable "kasm_user_password" {
  description = "The standard (non administrator) user password. No special characters"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = var.kasm_user_password == "" ? true : can(regex("^[a-zA-Z0-9]{12,40}", var.kasm_user_password))
    error_message = "The Kasm User should be a string between 12 and 40 letters or numbers with no special characters."
  }
}

variable "kasm_admin_password" {
  description = "The administrative user password. No special characters"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = var.kasm_admin_password == "" ? true : can(regex("^[a-zA-Z0-9]{12,40}", var.kasm_admin_password))
    error_message = "The Kasm Admin should be a string between 12 and 40 letters or numbers with no special characters."
  }
}

variable "kasm_manager_token" {
  description = "The manager token value for Agents to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = var.kasm_manager_token == "" ? true : can(regex("^[a-zA-Z0-9]{12,40}", var.kasm_manager_token))
    error_message = "The Manager Token should be a string between 12 and 40 letters or numbers with no special characters."
  }
}

variable "kasm_service_token" {
  description = "The service registration token value for Guac RDP servers to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = var.kasm_service_token == "" ? true : can(regex("^[a-zA-Z0-9]{12,40}", var.kasm_service_token))
    error_message = "The Service Registration Token should be a string between 12 and 40 letters or numbers with no special characters."
  }
}

variable "show_passwords" {
  description = "Show Kasm passwords in root Terraform output"
  type        = bool
  default     = true
}

variable "show_sa_credentials" {
  description = "Show GCP Service account credential file in output"
  type        = bool
  default     = true
}

## SSL Certificate variables
variable "use_gcp_certificate_manager" {
  description = "Use Certificate Manager to create and manage the Kasm public SSL certificate"
  type        = bool
  default     = false
}

variable "kasm_certificate_base_name" {
  description = "Name to use for Kasm Global SSL certificate"
  type        = string
  default     = "kasm-global-tls-certificate"

  validation {
    condition     = can(regex("^[a-z0-9-]{4,63}", var.kasm_certificate_base_name))
    error_message = "The kasm_certificate_base_name variable can only be a max of 63 characters consisting of lower case letters, numbers, and dash (-)."
  }
}

variable "kasm_certificate_dns_auth_base_name" {
  description = "Name to use for Kasm SSL DNS authorization service"
  type        = string
  default     = "kasm-global-certificate-dns-authorization"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,63}", var.kasm_certificate_dns_auth_base_name))
    error_message = "The kasm_certificate_dns_auth_base_name variable can only be a max of 63 characters beginning with a lower case letter, and consisting of lower case letters, numbers, and dash (-)."
  }
}

variable "kasm_cert_map_base_name" {
  description = "Name to use for Kasm Global SSL certificate map"
  type        = string
  default     = "kasm-global-certificate-map"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,63}", var.kasm_cert_map_base_name))
    error_message = "The kasm_cert_map_base_name variable can only be a max of 63 characters beginning with a lower case letter, and consisting of lower case letters, numbers, and dash (-)."
  }
}

## Webapp variables
variable "webapp_vm_instance_config" {
  description = "Webapp Compute instance configuration settings"
  type = object({
    machine_type = string
    disk_size_gb = string
    disk_type    = string
  })

  validation {
    condition     = tonumber(var.webapp_vm_instance_config.disk_size_gb) > 30
    error_message = "The webapp_vm_instance_config disk_size_gb should be larger than 30GB to support Kasm and other required services. Recommended minimum size is 50GB."
  }
  validation {
    condition     = contains(["pd-standard", "pd-ssd", "local-ssd", "pd-extreme"], var.webapp_vm_instance_config.disk_type)
    error_message = "The webapp_vm_instance_config disk_type attribute can only be one of pd-standard, pd-ssd, pd-extreme, or local-ssd."
  }
}

variable "webapp_named_ports" {
  description = "Webapp named ports for firewall and Google service connectivity"
  type = list(object({
    name = string
    port = number
  }))
  default = [
    {
      name = "https"
      port = 443
    }
  ]
}

variable "webapp_hostname_prefix" {
  description = "Webapp hostname prefix to use for instance group"
  type        = string
  default     = "webapp"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,63}", var.webapp_hostname_prefix))
    error_message = "The webapp_hostname_prefix variable can only be a max of 63 characters beginning with a lower case letter, and consisting of lower case letters, numbers, and dash (-)."
  }
}

variable "webapp_autoscale_min_instances" {
  description = "Webapp Autoscale minimum number of instances"
  type        = number
  default     = 2

  validation {
    condition     = var.webapp_autoscale_min_instances >= 1
    error_message = "The webapp_autoscale_min_instances should be 3 at a minimum since that is the typical number of availability domains for a region."
  }
}

variable "webapp_autoscale_max_instances" {
  description = "Webapp Autoscale maximum number of instances"
  type        = number
  default     = 5

  validation {
    condition     = var.webapp_autoscale_max_instances >= 1
    error_message = "The webapp_autoscale_max_instances should be larger than the webapp_autoscale_min_instances value."
  }
}

variable "webapp_autoscale_cool_down_period" {
  description = "Time in seconds for the autoscale group to wait before evaluating the health of the webapp"
  type        = number
  default     = 600

  validation {
    condition     = var.webapp_autoscale_cool_down_period >= 300
    error_message = "The webapp_autoscale_cool_down_periodc should be greater than 300 to allow webapps to be fully available before being evaluated with health checks. Kasm recommends around 600 or more."
  }
}

variable "webapp_autoscale_scale_out_cpu" {
  description = "Webapp Autoscale CPU percent to scale up webapps"
  type = list(object({
    target            = number
    predictive_method = string
  }))

  default = [{
    target            = 0.6
    predictive_method = "NONE"
  }]

  validation {
    condition     = alltrue([for value in var.webapp_autoscale_scale_out_cpu : value.target >= 0.5])
    error_message = "The webapp_autoscale_scale_out_cpu target attribute should be 0.5 at a minimum to prevent GCP from scaling webapps too aggressively."
  }
  validation {
    condition     = alltrue([for value in var.webapp_autoscale_scale_out_cpu : contains(["NONE", "OPTIMIZE_AVAILABILITY"], value.predictive_method)])
    error_message = "The webapp_autoscale_scale_out_cpu predictive_method attribute can only be one of NONE or OPTIMIZE_AVAILABILITY."
  }
}

variable "webapp_autoscale_scale_in_settings" {
  description = "Webapp Autoscale scale-in settings"
  type = object({
    fixed_replicas   = number
    time_window_sec  = number
    percent_replicas = optional(number, null)
  })
  default = {
    fixed_replicas  = 1
    time_window_sec = 600
  }

  validation {
    condition     = var.webapp_autoscale_scale_in_settings.fixed_replicas >= 1
    error_message = "The webapp_instance_group_scale_settings fixed_replicas should be 1 or more."
  }
  validation {
    condition     = var.webapp_autoscale_scale_in_settings.time_window_sec >= 300
    error_message = "The webapp_instance_group_scale_settings time_window_sec should be greater than 300 to allow webapps to be fully available before being evaluated with health checks. Kasm recommends around 600 or more."
  }
}

variable "webapp_health_check_name" {
  description = "Name of Webapp Managed Instance Group healthcheck"
  type        = string
  default     = "webapp-healthcheck"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,63}", var.webapp_health_check_name))
    error_message = "The webapp_health_check_name variable can only be a max of 63 characters beginning with a lower case letter, and consisting of lower case letters, numbers, and dash (-)."
  }
}

variable "webapp_health_check" {
  description = "HTTPS Managed Instance Group healthcheck for webapps."
  type = object({
    type                = string
    initial_delay_sec   = number
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    port                = number
    port_name           = string
    request_path        = string
    response            = optional(string, "")
    proxy_header        = optional(string, "NONE")
    request             = optional(string, "")
    host                = optional(string, "")
    enable_log          = optional(bool, false)
    enable_logging      = optional(string, false)
  })
  default = {
    type                = "https"
    initial_delay_sec   = 600
    check_interval_sec  = 30
    healthy_threshold   = 2
    timeout_sec         = 10
    unhealthy_threshold = 5
    port                = 443
    port_name           = "https"
    request_path        = "/api/__healthcheck"
  }
}

variable "webapp_instance_update_policy" {
  description = "The Instance group rolling update policy"
  type = list(object({
    instance_redistribution_type = string
    min_ready_sec                = number
    replacement_method           = string
    minimal_action               = string
    type                         = string
    max_surge_fixed              = optional(number, null)
    max_surge_percent            = optional(number, null) # Can only use if you run 10 or more instances
    max_unavailable_fixed        = optional(number, null)
    max_unavailable_percent      = optional(number, null) # Can only use if you run 10 or more instances
  }))
  default = [{
    minimal_action               = "REFRESH"
    type                         = "PROACTIVE"  # Update automatically
    max_surge_fixed              = 3            # Max new instances to startup
    max_unavailable_fixed        = 0            # Max instances to take offline before new ones available
    instance_redistribution_type = "PROACTIVE"  # Maintain even distribution across availability zones
    replacement_method           = "SUBSTITUTE" # Start new ones before taking any offline
    min_ready_sec                = 600          # Wait time before instance is ready
  }]

  validation {
    condition     = alltrue([for value in var.webapp_instance_update_policy : contains(["PROACTIVE", "OPPORTUNISTIC"], value.type)])
    error_message = "The webapp_instance_update_policy type setting only accepts PROACTIVE or OPPORTUNISTIC."
  }
  validation {
    condition     = alltrue([for value in var.webapp_instance_update_policy : contains(["PROACTIVE", "OPPORTUNISTIC"], value.instance_redistribution_type)])
    error_message = "The webapp_instance_update_policy instance_redistribution_type setting only accepts PROACTIVE or OPPORTUNISTIC."
  }
  validation {
    condition     = alltrue([for value in var.webapp_instance_update_policy : contains(["RECREATE", "SUBSTITUTE"], value.replacement_method)])
    error_message = "The webapp_instance_update_policy replacement_method setting only accepts RECREATE or SUBSTITUTE."
  }
  validation {
    condition     = alltrue([for value in var.webapp_instance_update_policy : value.min_ready_sec >= 300])
    error_message = "The webapp_instance_update_policy min_ready_sec should be greater than or equal to 300 seconds (5 min). Ideally, this should be around 600 seconds (10 min) to allow all install actions to take place."
  }
}

variable "public_load_balancer_name" {
  description = "GCP name for Global Public HTTPS Load balancer"
  type        = string
  default     = "webapp-global-load-balancer"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,63}", var.public_load_balancer_name))
    error_message = "The public_load_balancer_name variable can only be a max of 63 characters beginning with a lower case letter, and consisting of lower case letters, numbers, and dash (-)."
  }
}

variable "webapp_lb_health_check" {
  description = "HTTPS Load balancer and healthcheck for webapps."
  type = object({
    check_interval_sec  = optional(number)
    timeout_sec         = optional(number)
    healthy_threshold   = optional(number)
    unhealthy_threshold = optional(number)
    request_path        = optional(string)
    port                = optional(number)
    host                = optional(string)
    logging             = optional(bool)
  })
  default = {
    check_interval_sec  = 30
    timeout_sec         = 10
    healthy_threshold   = 2
    unhealthy_threshold = 3
    request_path        = "/api/__healthcheck"
    port                = 443
  }
}

## Database instance variables
variable "database_vm_instance_config" {
  description = "Database Compute instance configuration settings"
  type = object({
    machine_type     = string
    disk_size_gb     = number
    instance_role    = string
    name             = optional(string)
    name_prefix      = optional(string)
    disk_auto_delete = optional(bool)
    description      = optional(string)
    disk_type        = optional(string)
  })
}

## Agent instance variables
variable "agent_vm_instance_config" {
  description = "Agent Compute instance configuration settings"
  type = object({
    machine_type     = string
    disk_size_gb     = number
    instance_role    = string
    name             = optional(string)
    name_prefix      = optional(string)
    disk_auto_delete = optional(bool)
    description      = optional(string)
    disk_type        = optional(string)
  })
}

variable "number_of_agents_per_region" {
  description = "The number of static Kasm agents to deploy in each region. Set this to 0 to "
  type        = number
}

variable "enable_agent_nat_gateway" {
  description = "Deploy Kasm Agent behind a NAT gateway"
  type        = bool
  default     = false
}

variable "agent_gpu_enabled" {
  description = "Whether or not to automatically install GPU libraries. NOTE: This is useless unless you deploy Kasm agents using a GPU-based instance."
  type        = bool
  default     = false
}

## Connection Proxy (Guac) variables
variable "cpx_vm_instance_config" {
  description = "CPX Compute instance configuration settings"
  type = object({
    machine_type = string
    disk_size_gb = string
    disk_type    = string
  })

  validation {
    condition     = tonumber(var.cpx_vm_instance_config.disk_size_gb) > 30
    error_message = "The cpx_vm_instance_config disk_size_gb should be larger than 30GB to support Kasm and other required services. Recommended minimum size is 50GB."
  }
  validation {
    condition     = contains(["pd-standard", "pd-ssd", "local-ssd", "pd-extreme"], var.cpx_vm_instance_config.disk_type)
    error_message = "The cpx_vm_instance_config disk_type attribute can only be one of pd-standard, pd-ssd, pd-extreme, or local-ssd."
  }
}

variable "cpx_named_ports" {
  description = "CPX named ports for firewall and Google service connectivity"
  type = list(object({
    name = string
    port = number
  }))
  default = [
    {
      name = "https"
      port = 443
    }
  ]
}

variable "cpx_hostname_prefix" {
  description = "CPX hostname prefix to use for instance group"
  type        = string
  default     = "cpx"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,63}", var.cpx_hostname_prefix))
    error_message = "The cpx_hostname_prefix variable can only be a max of 63 characters consisting of lower case letters, numbers, and dash (-)."
  }
}

variable "cpx_autoscale_min_instances" {
  description = "CPX Autoscale minimum number of instances"
  type        = number
  default     = 1

  validation {
    condition     = var.cpx_autoscale_min_instances >= 1
    error_message = "The cpx_autoscale_min_instances should be 1 at a minimum to create the instance group."
  }
}

variable "cpx_autoscale_max_instances" {
  description = "CPX Autoscale maximum number of instances"
  type        = number
  default     = 5

  validation {
    condition     = var.cpx_autoscale_max_instances >= 2
    error_message = "The cpx_autoscale_max_instances should be 3 at a minimum since that is the typical number of availability domains for a region."
  }
}

variable "cpx_autoscale_cool_down_period" {
  description = "Time in seconds for the autoscale group to wait before evaluating the health of the webapp"
  type        = number
  default     = 600

  validation {
    condition     = var.cpx_autoscale_cool_down_period >= 300
    error_message = "The cpx_autoscale_cool_down_periodc should be greater than 300 to allow webapps to be fully available before being evaluated with health checks. Kasm recommends around 600 or more."
  }
}

variable "cpx_autoscale_scale_out_cpu" {
  description = "CPX Autoscale CPU percent to scale up webapps"
  type = list(object({
    target            = number
    predictive_method = optional(string, "NONE")
  }))

  default = [{
    target = 0.6
  }]

  validation {
    condition     = alltrue([for value in var.cpx_autoscale_scale_out_cpu : value.target >= 0.5])
    error_message = "The cpx_autoscale_scale_out_cpu target attribute should be 0.5 at a minimum to prevent GCP from scaling webapps too aggressively."
  }
  validation {
    condition     = alltrue([for value in var.cpx_autoscale_scale_out_cpu : contains(["NONE", "OPTIMIZE_AVAILABILITY"], value.predictive_method)])
    error_message = "The cpx_autoscale_scale_out_cpu predictive_method attribute can only be one of NONE or OPTIMIZE_AVAILABILITY."
  }
}

variable "cpx_autoscale_scale_in_settings" {
  description = "CPX Autoscale scale-in settings"
  type = object({
    fixed_replicas   = number
    time_window_sec  = number
    percent_replicas = optional(number, null)
  })
  default = {
    fixed_replicas  = 1
    time_window_sec = 600
  }

  validation {
    condition     = var.cpx_autoscale_scale_in_settings.fixed_replicas >= 1
    error_message = "The cpx_instance_group_scale_settings fixed_replicas should be 1 or more."
  }
  validation {
    condition     = var.cpx_autoscale_scale_in_settings.time_window_sec >= 300
    error_message = "The cpx_instance_group_scale_settings time_window_sec should be greater than 300 to allow webapps to be fully available before being evaluated with health checks. Kasm recommends around 600 or more."
  }
}

variable "cpx_instance_update_policy" {
  description = "The CPX Instance group rolling update policy"
  type = list(object({
    instance_redistribution_type = string
    min_ready_sec                = number
    replacement_method           = string
    minimal_action               = string
    type                         = string
    max_surge_fixed              = optional(number, null)
    max_surge_percent            = optional(number, null) # Can only use if you run 10 or more instances
    max_unavailable_fixed        = optional(number, null)
    max_unavailable_percent      = optional(number, null) # Can only use if you run 10 or more instances
  }))
  default = [{
    minimal_action               = "REFRESH"
    type                         = "PROACTIVE"  # Update automatically
    max_surge_fixed              = 3            # Max new instances to startup
    max_unavailable_fixed        = 0            # Max instances to take offline before new ones available
    instance_redistribution_type = "PROACTIVE"  # Automatically distribute nodes across availability zones
    replacement_method           = "SUBSTITUTE" # Start new ones before taking any offline
    min_ready_sec                = 600          # Wait time before instance is ready
  }]


  validation {
    condition     = alltrue([for value in var.cpx_instance_update_policy : contains(["PROACTIVE", "OPPORTUNISTIC"], value.type)])
    error_message = "The cpx_instance_update_policy instance_redistribution_type setting only accepts PROACTIVE or OPPORTUNISTIC."
  }
  validation {
    condition     = alltrue([for value in var.cpx_instance_update_policy : contains(["PROACTIVE", "OPPORTUNISTIC"], value.instance_redistribution_type)])
    error_message = "The cpx_instance_update_policy instance_redistribution_type setting only accepts PROACTIVE or OPPORTUNISTIC."
  }
  validation {
    condition     = alltrue([for value in var.cpx_instance_update_policy : contains(["RECREATE", "SUBSTITUTE"], value.replacement_method)])
    error_message = "The cpx_instance_update_policy replacement_method setting only accepts RECREATE or SUBSTITUTE."
  }
  validation {
    condition     = alltrue([for value in var.cpx_instance_update_policy : value.min_ready_sec >= 300])
    error_message = "The cpx_instance_update_policy min_ready_sec should be greater than or equal to 300 seconds (5 min). Ideally, this should be around 600 seconds (10 min) to allow all install actions to take place."
  }
}

## DNS variables
variable "create_public_dns_zone" {
  description = "Set to true if you wish to create a public DNS zone for this Kasm instance. If not, the public_dns_friendly_name should belong to an existing DNS zone."
  type        = bool
  default     = true
}

variable "public_dns_friendly_name" {
  description = "Public DNS Zone resource name. If not creating a new DNS Zone, make sure the desired DNS zone already exists."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,63}", var.public_dns_friendly_name))
    error_message = "The public_dns_friendly_name variable can only be a max of 63 characters beginning with a lower case letter, and consisting of lower case letters, numbers, and dash (-)."
  }
}

variable "private_dns_friendly_name" {
  description = "Private DNS Zone resource name"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,63}", var.private_dns_friendly_name))
    error_message = "The private_dns_friendly_name variable can only be a max of 63 characters beginning with a lower case letter, and consisting of lower case letters, numbers, and dash (-)."
  }
}

## Kasm default image source
variable "kasm_source_image" {
  description = "The source VM Image information to use for deploying Kasm. Recommended to use Ubuntu 20.04 Minimal. You can either explicitly define the source image to use, or the image project and family so that Terraform always chooses the latest."
  type = object({
    source_image = optional(string, null)
    project      = optional(string, null)
    family       = optional(string, null)
  })

  default = {
    project = "ubuntu-os-cloud"
    family  = "ubuntu-minimal-2004-lts"
  }
}

## GCP Service account used autoscaling and instance updates
variable "compute_service_account" {
  description = "Compute service account to use for CPX autoscaling"
  type = object({
    email  = optional(string)
    scopes = list(string)
  })

  default = {
    email  = ""
    scopes = ["cloud-platform"]
  }
}

## Additional install options
variable "additional_kasm_install_options" {
  description = "Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details."
  type        = list(string)
  default     = ["-O"]
}

variable "additional_webapp_install_options" {
  description = "Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details."
  type        = list(string)
  default     = []
}

variable "additional_database_install_options" {
  description = "Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details."
  type        = list(string)
  default     = []
}

variable "additional_agent_install_options" {
  description = "Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details."
  type        = list(string)
  default     = []
}

variable "additional_cpx_install_options" {
  description = "Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details."
  type        = list(string)
  default     = []
}

## Additional Kasm features
variable "deploy_connection_proxy" {
  description = "Deploy Kasm Guacamole Server for RDP/SSH access to physical servers"
  type        = bool
  default     = false
}

variable "deploy_windows_hosts" {
  description = "Create a subnet and Firewall rules for Windows hosts. These hosts must be deployed manually, or you'll need to add your own compute entry for Windows hosts."
  type        = bool
  default     = false
}

## Kasm Autoscale Service Account
variable "create_kasm_autoscale_service_account" {
  description = "Create a GCP service account capable of managing Kasm Cloud Autoscaling for GCP agents"
  type        = bool
  default     = false
}

variable "service_account_name" {
  description = "Account name to use for Kasm Autoscaling service account"
  type        = string
  default     = ""
}

## Firewall rules
variable "kasm_firewall_security_tags" {
  description = "Firewall tags to use for Kasm CPX firewall rules"
  type = object({
    webapp   = list(string)
    database = list(string)
    agent    = list(string)
    cpx      = optional(list(string), [])
    windows  = optional(list(string), [])
  })
  default = {
    webapp   = ["webapp"]
    database = ["database"]
    agent    = ["kasm-agent"]
    cpx      = ["kasm-cpx"]
    windows  = ["kasm-windows"]
  }
}

variable "custom_firewall_rules" {
  description = "Additional, custom firewall rules"
  type = list(object({
    name                    = string
    description             = optional(string, null)
    direction               = optional(string, null)
    priority                = optional(number, null)
    ranges                  = optional(list(string), null)
    source_tags             = optional(list(string), null)
    source_service_accounts = optional(list(string), null)
    target_tags             = optional(list(string), null)
    target_service_accounts = optional(list(string), null)
    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), null)
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), null)
    log_config = optional(object({
      metadata = string
    }), null)
  }))
  default = []
}

## Add any required custom routes to match your environment
variable "custom_kasm_routes" {
  description = "Custom routes to add to VPC"
  type = list(object({
    name                   = string
    destination_range      = string
    description            = optional(string, null)
    priority               = optional(number, null)
    next_hop_internet      = optional(bool, false)
    next_hop_ip            = optional(string, null)
    next_hop_instance      = optional(string, null)
    next_hop_instance_zone = optional(string, null)
    next_hop_vpn_tunnel    = optional(string, null)
    next_hop_ilb           = optional(string, null)
    tags                   = optional(list(string), [])
  }))
  default = []
}

## Default labels to apply to all resources
variable "resource_labels" {
  description = "Default tags to add to Terraform-deployed Kasm services"
  type        = map(any)
  default     = null
}
