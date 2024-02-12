locals {
  kasm_agent_vpc_subnet_cidr_mask    = split("/", var.agent_vpc_cidr)[1]
  kasm_agent_subnet_cidr_calculation = (8 - (local.kasm_agent_vpc_subnet_cidr_mask - 16))
  kasm_agent_subnet_cidr_size        = local.kasm_agent_subnet_cidr_calculation < 3 ? 3 : local.kasm_agent_subnet_cidr_calculation

  all_security_groups = compact([
    aws_security_group.public_lb.id,
    aws_security_group.proxy.id,
    aws_security_group.agent.id,
    one(aws_security_group.cpx[*].id),
    one(aws_security_group.windows[*].id)
  ])

  proxy_security_rules = { for value in local.all_security_groups : value => var.proxy_security_rules if value == aws_security_group.public_lb.id }
}

data "aws_route53_zone" "this" {
  name         = var.aws_domain_name
  private_zone = false
}

data "aws_availability_zones" "available" {
  state = "available"
}
