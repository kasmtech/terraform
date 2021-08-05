provider "aws" {
  region     = "${var.primary_aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

data "aws_availability_zones" "available" {
  state = "available"
}