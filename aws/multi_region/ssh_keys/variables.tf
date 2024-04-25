variable "ssh_authorized_keys" {
  description = "The SSH Public Keys to be installed on the OCI compute instance"
  type        = string
}

variable "project_name" {
  description = "The name of the deployment (e.g dev, staging). A short single word"
  type        = string
}