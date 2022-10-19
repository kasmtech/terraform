variable "project_name" {
  description = "The name of the project/deployment/company eg (acme). Lower case all one word as this will be used in a domain name"
}
variable "digital_ocean_token" {
  description = "Authentication Token For Digital Ocean"
}
variable "digital_ocean_region" {
  description = "The Default Digital Ocean Region Slug: https://docs.digitalocean.com/products/platform/availability-matrix/"
  default     = "nyc3"
}
variable "digital_ocean_droplet_slug" {
  description = "The Default Digital Ocean Droplet Slug: https://slugs.do-api.dev/"
  default     = "s-2vcpu-4gb-intel"
}
variable "digital_ocean_image" {
  description = "Default Image for Ubuntu LTS"
  default     = "docker-18-04"
}
variable "kasm_build_url" {
  description = "The Build file to install"
  default     = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.9.0.077388.tar.gz"
}
variable "user_password" {
  default     = "changeme"
  description = "The default password to be used for the default user@kasm.local account. Only use alphanumeric characters"
}
variable "admin_password" {
  default     = "changeme"
  description = "The default password to be used for the default admin@kasm.local account. Only use alphanumeric characters"
}
variable "allow_ssh_cidrs" {
  description = "CIDR notation for hosts allowed to SSH"
}
variable "do_domain_name" {
  description = "The domain name that users will use to access kasm"
}
variable "ssh_key_fingerprints" {
  # The ssh key fingerprints from uploaded keys can be obtained at https://cloud.digitalocean.com/account/security
  description = "Keys used for sshing into kasm hosts"
}

variable swap_size {
  description = "The amount of swap (in MB) to configure inside the compute instances"
  default = 2048
}

variable vpc_uuid {
  description = "The UUID of the VPC to deploy the kasm server into"
}
