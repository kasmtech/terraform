locals {
  private_lb_hostname = "${var.aws_region}-private.${var.aws_domain_name}"

  all_security_groups = compact([
    aws_security_group.public_lb.id,
    aws_security_group.private_lb.id,
    aws_security_group.webapp.id,
    aws_security_group.agent.id,
    aws_security_group.db.id,
    one(aws_security_group.cpx[*].id),
    one(aws_security_group.windows[*].id)
  ])

  webapp_security_rules = { for value in local.all_security_groups : value => var.webapp_security_rules if value != aws_security_group.db.id || value != aws_security_group.webapp.id }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_route53_zone" "this" {
  name = var.aws_domain_name
}

data "aws_elb_service_account" "main" {}
