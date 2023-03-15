locals {
  kasm_agent_vpc_subnet_cidr_mask    = split("/", var.agent_vpc_cidr)[1]
  kasm_agent_subnet_cidr_calculation = (8 - (local.kasm_agent_vpc_subnet_cidr_mask - 16))
  kasm_agent_subnet_cidr_size        = local.kasm_agent_subnet_cidr_calculation < 0 ? 0 : local.kasm_agent_subnet_cidr_calculation
}

resource "aws_subnet" "kasm-agent-subnet" {
  vpc_id                  = data.aws_vpc.data-kasm_agent_vpc.id
  cidr_block              = cidrsubnet(var.agent_vpc_cidr, local.kasm_agent_subnet_cidr_size, 0)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-agent-subnet"
  }
}

data "aws_subnet" "data-kasm_agent_subnet" {
  id = aws_subnet.kasm-agent-subnet.id
}
