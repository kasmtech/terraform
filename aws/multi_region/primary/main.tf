provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

data "aws_availability_zones" "available" {
  state = "available"
}

output "primary_aws_region" {
  value = "${var.aws_region}"
}

