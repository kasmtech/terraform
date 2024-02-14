locals {
  kasm_agent_vpc_subnet_cidr_mask    = split("/", var.agent_vpc_cidr)[1]
  kasm_agent_subnet_cidr_calculation = (8 - (local.kasm_agent_vpc_subnet_cidr_mask - 16))
  kasm_agent_subnet_cidr_size        = local.kasm_agent_subnet_cidr_calculation < 3 ? 3 : local.kasm_agent_subnet_cidr_calculation

  region_short_name_for_lb = join("", slice(split("-", var.aws_region), 1, 3))
}

data "aws_route53_zone" "this" {
  name         = var.aws_domain_name
  private_zone = false
}

data "aws_availability_zones" "available" {
  state = "available"
}
