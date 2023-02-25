variable "aws_domain_name" {
  default = "kasm.contoso.com"
}

variable "project_name" {
  default = "contoso"
}

variable "aws_key_pair" {
  default = ""
}

variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "database_password" {
  default = "changeme"
}

variable "redis_password" {
  default = "changeme"
}

variable "user_password" {
  default = "changeme"
}

variable "admin_password" {
  default = "changeme"
}

variable "manager_token" {
  default = "changeme"
}

variable "kasm_build" {
  default = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.12.0.d4fd8a.tar.gz"
}

variable "ssh_access_cidr" {
  default = "0.0.0.0/0"
}
