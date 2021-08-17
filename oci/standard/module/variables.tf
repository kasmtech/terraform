variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
}

variable "oci_domain_name" {
  description = "The public Zone used for the dns entries. This must already exist in the OCI account. (e.g kasm.contoso.com). The deployment will be accessed via this zone name via https"
}

variable kasm_build_url {
  description = "The URL for the Kasm Workspaces build"
}


variable swap_size {
  description = "The amount of swap (in MB) to configure inside the compute instances"
  default = 2048
}


variable "tenancy_ocid" {
  description = "The Tenancy OCID."
}

variable "user_ocid" {
  description = "The User OCID."
}

variable "compartment_ocid" {
  description = "The Compartment OCID"
}

variable "region" {
  description = "The OCI Region eg: (us-ashburn-1)"
}

variable "fingerprint" {
  description = "API Key Fingerprint"
}

variable "private_key_path" {
  description = "The path to the API Key PEM encoded Private Key"
}

variable "ssh_authorized_keys" {
  description = "The file path to the authorized_keys file that contains SSH public keys to be installed on the OCI compute instance"
}

variable "instance_image_ocid" {
  description = "The OCID for the instance image , such as ubuntu 18.04, to use."
  default = "ocid1.image.oc1.iad.aaaaaaaafg6lg7dejwjebjqontwzyvutgf6qs5awyze6fgoiqepyj5qkvcuq"
}


variable "allow_ssh_cidr" {
  description = "The CIDR notation to allow SSH access to the systems."
  default = "0.0.0.0/0"
}

variable "allow_web_cidr" {
  description = "The CIDR notation to allow HTTPS access to the systems."
  default = "0.0.0.0/0"
}

variable "kasm_ssl_crt_path" {
  description = "The file path to the PEM encoded SSL Certificate"
}

variable "kasm_ssl_key_path" {
  description = "The file path to the PEM encoded SSL Certificate Key"
}


variable "instance_shape" {
  description = "The instance shape to use. Should be a Flex type."
  default = "VM.Standard.E3.Flex"
}

variable "db_boot_size_gb" {
  description = "The size, in GB, of the DB instance drive"
  default = 50
}

variable "webapp_boot_size_gb" {
  description = "The size, in GB, of the Webapp instance drives"
  default = 50
}

variable "agent_boot_size_gb" {
  description = "The size, in GB, of the Agemt instance drives"
  default = 60
}


variable "num_agents" {
  default     = "2"
  description = "The number of Agent Role Servers to create in the deployment"
}


variable "num_webapps" {
  default     = "2"
  description = "The number of WebApp role servers to create in the deployment"
}


variable "agent_ocpus" {
  description = "The number of CPUs to configure for the Agent instances"
  default = 2
}

variable "db_ocpus" {
  description = "The number of CPUs to configure for the DB instance"
  default = 1
}

variable "webapp_ocpus" {
  description = "The number of CPUs to configure for the Webapp instances"
  default = 1
}

variable "agent_memory_in_gb" {
  description = "The amount of memory, in GB, to configure for the Agent instances"
  default = 4
}

variable "webapp_memory_in_gb" {
  description = "The amount of memory, in GB, to configure for the Webapp instances"
  default = 2
}

variable "db_memory_in_gb" {
  description = "The amount of memory, in GB, to configure for the DB instance"
  default = 2
}

variable "manager_token" {
  description = "The password for the database. No special characters"
}
variable "database_password" {
  description = "The password for the database. No special characters"
}
variable "redis_password" {
  description = "The password for the database. No special characters"
}
variable "user_password" {
  description = "The password for the database. No special characters"
}
variable "admin_password" {
  description = "The password for the database. No special characters"
}
variable "webapp_cidr_1" {
  default = "10.0.20.0/24"
}
variable "webapp_cidr_2" {
  default = "10.0.25.0/24"
}