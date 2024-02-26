locals {
  private_lb_hostname = "${var.aws_region}-private.${var.aws_domain_name}"

}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_route53_zone" "this" {
  name = var.aws_domain_name
}

data "aws_elb_service_account" "main" {}
