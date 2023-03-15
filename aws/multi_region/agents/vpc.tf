resource "aws_vpc" "kasm-agent-vpc" {
  cidr_block           = var.agent_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-vpc"
  }
}

data "aws_vpc" "data-kasm_agent_vpc" {
  id = aws_vpc.kasm-agent-vpc.id
}

resource "aws_internet_gateway" "kasm-default-ig" {
  vpc_id = data.aws_vpc.data-kasm_agent_vpc.id
  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-ig"
  }
}

data "aws_internet_gateway" "data-kasm_agent_default_ig" {
  internet_gateway_id = aws_internet_gateway.kasm-default-ig.id
}
