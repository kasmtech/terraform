data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_elb_service_account" "main" {}

data "aws_route53_zone" "this" {
  name         = var.aws_domain_name
  private_zone = false
}
