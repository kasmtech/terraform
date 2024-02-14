locals {
  region_short_name_for_lb = join("", slice(split("-", var.faux_aws_region), 1, 3))
}

data "aws_route53_zone" "this" {
  name         = var.aws_domain_name
  private_zone = false
}
