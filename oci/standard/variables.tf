variable "tenancy_ocid" {
  description = "The Tenancy OCID."
  type        = string

  validation {
    condition     = can(regex("^(ocid\\d)\\.(compartment|tenancy)\\.(oc\\d)[.]{1,}[a-z0-9]{60}", var.tenancy_ocid))
    error_message = "The tenancy_ocid must be a valid Oracle Cloud Tenancy OCID value (e.g. ocid1.tenancy.oc1..aaaaaaaaba3pv6wkcr4jqae5f44n2b2m2yt2j6rx32uzr4h25vqstifsfdsq)."
  }
}

variable "user_ocid" {
  description = "The User OCID."
  type        = string

  validation {
    condition     = can(regex("^(ocid\\d)\\.(user)\\.(oc\\d)[.]{1,}[a-z0-9]+", var.user_ocid))
    error_message = "The variable user_ocid must be a valid Oracle Cloud User OCID."
  }
}

variable "compartment_ocid" {
  description = "The Compartment OCID"
  type        = string

  validation {
    condition     = can(regex("^(ocid\\d)\\.(compartment|tenancy)\\.(oc\\d)[.]+[a-z0-9]{60}", var.compartment_ocid))
    error_message = "The compartment_ocid must be a valid Oracle Cloud Compartment OCID value (e.g. ocid1.compartment.oc1..aaaaaaaaba3pv6wkcr4jqae5f44n2b2m2yt2j6rx32uzr4h25vqstifsfdsq)."
  }
}

variable "region" {
  description = "The OCI Region eg: (us-ashburn-1)"
  type        = string

  validation {
    condition     = can(regex("^([a-z]{2}-[a-z]{5,}-[\\d]{1})$", var.region))
    error_message = "The provider-oci_deployment_region must be a valid Oracle Cloud (OCI) Region name, e.g. us-ashburn-1"
  }
}

variable "fingerprint" {
  description = "API Key Fingerprint"
  type        = string

  validation {
    condition     = can(regex("^([a-f0-9]{2}:?){16}$", var.fingerprint))
    error_message = "The API fingerprint is incorrectly formatted. It should be 16 colon-delimited hex bytes  (e.g. 12:34:56:78:90:ab:cd:ef:12:34:56:78:90:ab:cd:ef)."
  }
}

variable "private_key_path" {
  description = "The path to the API Key PEM encoded Private Key"
  type        = string
  sensitive   = true

  validation {
    condition     = fileexists(var.private_key_path)
    error_message = "The variable private_key_path must point to a valid OCI API Key file."
  }

  validation {
    condition     = !can(regex("replaceme", file(var.private_key_path)))
    error_message = "You must enter a valid OCI API Private key in the file located at the private_key_path."
  }
}
variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
  type        = string

  validation {
    condition     = can(regex("^[a-z]{1,15}", var.project_name))
    error_message = "The project_name variable can only be one word between 1 and 15 lower-case letters since it is a seed value in multiple object names."
  }
}

variable "oci_domain_name" {
  description = "The public Zone used for the dns entries. This must already exist in the OCI account. (e.g kasm.contoso.com). The deployment will be accessed via this zone name via https"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,6}", var.oci_domain_name))
    error_message = "There are invalid characters in the oci_domain_name - it must be a valid domain name."
  }
}

variable "vcn_subnet_cidr" {
  description = "VCN Subnet CIDR where you wish to deploy Kasm"
  type        = string

  validation {
    condition     = can(cidrhost(var.vcn_subnet_cidr, 0))
    error_message = "The vcn_subnet_cidr must be a valid IPv4 Subnet in CIDR notation (e.g. 10.0.0.0/24)."
  }
}

variable "ssh_authorized_keys" {
  description = "The SSH Public Keys to be installed on the OCI compute instance"
  type        = string

  validation {
    condition     = can(regex("^ssh-rsa\\s+[A-Za-z0-9+/]+[=]{0,3}(\\s+.+)?\\s*$", var.ssh_authorized_keys))
    error_message = "The ssh_authorized_keys value is not in the correct format."
  }
}

variable "instance_image_ocid" {
  description = "The OCID for the instance image, such as ubuntu 22.04, to use."
  type        = string

  validation {
    condition     = can(regex("^(ocid\\d)\\.(image)\\.(oc\\d)\\.[a-z]{3,}\\.[a-z0-9]{60}", var.instance_image_ocid))
    error_message = "The compartment_ocid must be a valid Oracle Cloud Compartment OCID value (e.g. ocid1.image.oc1.iad.aaaaaaaafg6lg7dejwjebjqontwzyvutgf6qs5awyze6fgoiqepyj5qkvcuq)."
  }
}

variable "allow_ssh_cidrs" {
  description = "The CIDR notation to allow SSH access to the systems."
  type        = list(string)

  validation {
    condition     = alltrue([for subnet in var.allow_ssh_cidrs : can(cidrhost(subnet, 0))])
    error_message = "One of the subnets provided in the allow_ssh_cidrs list is invalid."
  }
}

variable "allow_web_cidrs" {
  description = "The CIDR notation to allow HTTPS access to the systems."
  type        = list(string)

  validation {
    condition     = alltrue([for subnet in var.allow_web_cidrs : can(cidrhost(subnet, 0))])
    error_message = "One of the subnets provided in the allow_web_cidrs list is invalid."
  }
}

variable "letsencrypt_cert_support_email" {
  description = "Email address to use for Let's Encrypt SSL certificates for OCI Deployment"
  type        = string
  default     = ""

  validation {
    condition     = var.letsencrypt_cert_support_email == "" ? true : can(regex("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", var.letsencrypt_cert_support_email))
    error_message = "The ssl_cert_support_email must be a valid email address format."
  }
}

variable "letsencrypt_server_type" {
  description = "SSL Server type to generate. Valid options are staging and prod, and prod certificates are limited to 5 certificates per week."
  type        = string
  default     = ""

  validation {
    condition     = contains(["staging", "prod", ""], var.letsencrypt_server_type)
    error_message = "Allowed values for the letsencrypt_server_type variable are: staging, prod. For reference: Staging generates certificates that a browser will not trust, but are formatted correctly to apply to resources; while Prod generates valid, useable, trusted certificates. NOTE: Prod certificate generation is limited to 5 times per week, so if you are testing Kasm or intend to possibly re-deploy multiple times, it is recommended to use Staging (which has a much higher generation limit since it is intended for testing) until you are ready to deploy your 'final' version."
  }
}

variable "kasm_ssl_crt_path" {
  description = "The file path to the PEM encoded SSL Certificate"
  type        = string
  default     = ""

  validation {
    condition     = var.kasm_ssl_crt_path == "" ? true : can(fileexists(var.kasm_ssl_crt_path))
    error_message = "The variable kasm_ssl_crt_path must point to a valid OCI API Key file."
  }

  validation {
    condition     = var.kasm_ssl_crt_path == "" ? true : !can(regex("replaceme", file(var.kasm_ssl_crt_path)))
    error_message = "You must enter a valid SSL Cert in the file located at the kasm_ssl_crt_path."
  }
}

variable "kasm_ssl_key_path" {
  description = "The file path to the PEM encoded SSL Certificate Key"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = var.kasm_ssl_key_path == "" ? true : can(fileexists(var.kasm_ssl_key_path))
    error_message = "The variable kasm_ssl_key_path must point to a valid OCI API Key file."
  }

  validation {
    condition     = var.kasm_ssl_key_path == "" ? true : !can(regex("replaceme", file(var.kasm_ssl_key_path)))
    error_message = "You must enter a valid SSL Cert in the file located at the kasm_ssl_key_path."
  }
}

variable "database_password" {
  description = "The password for the database. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.database_password))
    error_message = "The Database Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "redis_password" {
  description = "The password for the Redis server. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.redis_password))
    error_message = "The Redis Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "user_password" {
  description = "The standard (non administrator) user password. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.user_password))
    error_message = "The User Password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "admin_password" {
  description = "The administrative user password. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.admin_password))
    error_message = "The Admin password should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "manager_token" {
  description = "The manager token value for Agents to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.manager_token))
    error_message = "The Manager Token should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "service_registration_token" {
  description = "The service registration token value for cpx RDP servers to authenticate to webapps. No special characters"
  type        = string
  sensitive   = true

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{12,30}$", var.service_registration_token))
    error_message = "The Service Registration Token should be a string between 12 and 30 letters or numbers with no special characters."
  }
}

variable "num_agents" {
  description = "The number of Agent Role Servers to create in the deployment"
  type        = number

  validation {
    condition     = var.num_agents >= 0 && var.num_agents <= 100 && floor(var.num_agents) == var.num_agents
    error_message = "Acceptable number of Kasm Agents range between 0-100."
  }
}

variable "num_cpx_nodes" {
  description = "The number of cpx RDP Role Servers to create in the deployment"
  type        = number

  validation {
    condition     = var.num_cpx_nodes >= 0 && var.num_cpx_nodes <= 100 && floor(var.num_cpx_nodes) == var.num_cpx_nodes
    error_message = "Acceptable number of Kasm cpx RDP nodes range between 0-100."
  }
}

variable "num_webapps" {
  description = "The number of WebApp role servers to create in the deployment"
  type        = number

  validation {
    condition     = var.num_webapps >= 1 && var.num_webapps <= 3 && floor(var.num_webapps) == var.num_webapps
    error_message = "Acceptable number of Kasm Agents range between 1-3."
  }
}

variable "swap_size" {
  description = "The amount of swap (in MB) to configure inside the compute instances"
  type        = number

  validation {
    condition     = var.swap_size >= 1024 && var.swap_size <= 8192 && floor(var.swap_size) == var.swap_size
    error_message = "Swap size is the amount of disk space to use for Kasm in MB and must be an integer between 1024 and 8192."
  }
}

variable "kasm_webapp_vm_settings" {
  description = "The number of CPUs, amount of memory in GB, and HDD size in GB to configure for the Kasm WebApp instances"
  type = object({
    cpus        = number
    memory      = number
    hdd_size_gb = number
  })

  validation {
    condition     = var.kasm_webapp_vm_settings.cpus >= 1
    error_message = "Kasm Webapps should have at least 1 CPUs to ensure enough resources for Kasm services."
  }
  validation {
    condition     = var.kasm_webapp_vm_settings.memory >= 2
    error_message = "Kasm Webapps should have at least 2 GB Memory to ensure enough resources for Kasm services."
  }
  validation {
    condition     = var.kasm_webapp_vm_settings.hdd_size_gb >= 50
    error_message = "Kasm Webapps should have at least a 50 GB HDD to meet OCI minimum requirements, and ensure enough space Kasm services."
  }
}

variable "kasm_database_vm_settings" {
  description = "The number of CPUs, amount of memory in GB, and HDD size in GB to configure for the Kasm Database instance"
  type = object({
    cpus        = number
    memory      = number
    hdd_size_gb = number
  })

  validation {
    condition     = var.kasm_database_vm_settings.cpus >= 1
    error_message = "Kasm Webapps should have at least 1 CPUs to ensure enough resources for Kasm services."
  }
  validation {
    condition     = var.kasm_database_vm_settings.memory >= 2
    error_message = "Kasm Webapps should have at least 2 GB Memory to ensure enough resources for Kasm services."
  }
  validation {
    condition     = var.kasm_database_vm_settings.hdd_size_gb >= 50
    error_message = "Kasm Webapps should have at least a 50 GB HDD to meet OCI minimum requirements, and ensure enough space Kasm services."
  }
}

variable "kasm_agent_vm_settings" {
  description = "The number of CPUs, amount of memory in GB, and HDD size in GB to configure for the Kasm Agent instances"
  type = object({
    cpus        = number
    memory      = number
    hdd_size_gb = number
  })

  validation {
    condition     = var.kasm_agent_vm_settings.cpus >= 2
    error_message = "Kasm Agents should have at least 2 CPUs to ensure enough resources for Kasm services. More CPU is definitely better for the Kasm Agent as it is the VM that runs your Kasm workspaces."
  }
  validation {
    condition     = var.kasm_agent_vm_settings.memory >= 2
    error_message = "Kasm Agents should have at least 4 GB Memory to ensure enough resources for Kasm services. More Memory is definitely better for the Kasm Agent as it is the VM that runs your Kasm workspaces."
  }
  validation {
    condition     = var.kasm_agent_vm_settings.hdd_size_gb >= 120
    error_message = "Kasm Agents should have at least a 120 GB HDD to meet OCI minimum requirements, and ensure enough space to pull the default Kasm workspace images."
  }
}

variable "kasm_cpx_vm_settings" {
  description = "The number of CPUs, amount of memory in GB, and HDD size in GB to configure for the Kasm cpx RDP instances"
  type = object({
    cpus        = number
    memory      = number
    hdd_size_gb = number
  })

  validation {
    condition     = var.kasm_cpx_vm_settings.cpus >= 2
    error_message = "Kasm cpx RDP servers should have at least 2 CPUs to ensure enough resources for Kasm services."
  }
  validation {
    condition     = var.kasm_cpx_vm_settings.memory >= 2
    error_message = "Kasm cpx RDP servers should have at least 2 GB Memory to ensure enough resources for Kasm services."
  }
  validation {
    condition     = var.kasm_cpx_vm_settings.hdd_size_gb >= 50
    error_message = "Kasm cpx RDP servers should have at least a 50 GB HDD to meet OCI minimum requirements, and ensure enough space Kasm services."
  }
}

variable "bastion_vm_settings" {
  description = "The number of CPUs, amount of memory in GB, and HDD size in GB to configure for the Kasm SSH Bastion instance"
  type = object({
    cpus        = number
    memory      = number
    hdd_size_gb = number
  })

  validation {
    condition     = var.bastion_vm_settings.cpus >= 1
    error_message = "Kasm SSH Bastion should have at least 2 CPUs to ensure enough resources for Kasm services."
  }
  validation {
    condition     = var.bastion_vm_settings.memory >= 1
    error_message = "Kasm SSH Bastion should have at least 2 GB Memory to ensure enough resources for Kasm services."
  }
  validation {
    condition     = var.bastion_vm_settings.hdd_size_gb >= 50
    error_message = "Kasm SSH Bastion should have at least a 50 GB HDD to meet OCI minimum requirements."
  }
}

## Non-validated variables
variable "kasm_build_url" {
  description = "The URL for the Kasm Workspaces build"
  type        = string
}

variable "instance_shape" {
  description = "The instance shape to use. Should be a Flex type."
  type        = string
}

## Local for Let's Encrypt staging/prod URL selection
locals {
  letsencrypt_server_url = var.letsencrypt_server_type == "prod" ? "https://acme-v02.api.letsencrypt.org/directory" : "https://acme-staging-v02.api.letsencrypt.org/directory"
}
