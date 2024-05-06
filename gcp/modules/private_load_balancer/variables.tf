variable "project" {
  description = "The project to deploy to, if not set the default provider project is used."
  type        = string
  default     = ""
}

variable "region" {
  description = "Region for cloud resources."
  type        = string
}

variable "global_access" {
  description = "Allow all regions on the same VPC network access."
  type        = bool
  default     = false
}

variable "network" {
  description = "Name of the network to create resources in."
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "Name of the subnetwork to create resources in."
  type        = string
  default     = "default"
}

variable "network_project" {
  description = "Name of the project for the network. Useful for shared VPC. Default is var.project."
  type        = string
  default     = ""
}

variable "name" {
  description = "Name for the forwarding rule and prefix for supporting resources."
  type        = string
}

variable "backends" {
  description = "List of backends, should be a map of key-value pairs for each backend, must have the 'group' key."
  type        = list(any)
}

variable "backend_timeout_sec" {
  description = "Backend timeout"
  type        = number
  default     = 30
}

variable "load_balancing_scheme" {
  description = "The load balancing scheme to use. The default is INTERNAL"
  type        = string
  default     = "INTERNAL_MANAGED"
}

variable "load_balancing_policy" {
  description = "The load balancing policy to use"
  type        = string
  default     = "ROUND_ROBIN"
}

variable "named_port" {
  description = "Named port to allow access to the LB or resources through the VPC FW"
  type        = string
}

variable "session_affinity" {
  description = "The session affinity for the backends example: NONE, CLIENT_IP. Default is `NONE`."
  type        = string
  default     = "NONE"
}

variable "port_range" {
  description = "List of ports range to forward to backend services. Max is 5."
  type        = string
}

variable "health_check" {
  description = "Health check to determine whether instances are responsive and able to do work"
  type = object({
    type                = string
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    response            = string
    proxy_header        = string
    port                = number
    port_name           = string
    request             = string
    request_path        = string
    host                = string
    enable_log          = bool
  })
}

variable "ip_protocol" {
  description = "The IP protocol for the backend and frontend forwarding rule. TCP or UDP."
  type        = string
  default     = "TCP"
}

variable "connection_draining_timeout_sec" {
  description = "Time for which instance will be drained"
  default     = 300
  type        = number
}

variable "labels" {
  description = "The labels to attach to resources created by this module."
  default     = {}
  type        = map(string)
}
