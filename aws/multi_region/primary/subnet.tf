locals {
  kasm_vpc_subnet_cidr_mask           = split("/", var.vpc_subnet_cidr)[1]
  kasm_server_subnet_cidr_calculation = (8 - (local.kasm_vpc_subnet_cidr_mask - 16))
  kasm_server_subnet_cidr_size        = local.kasm_server_subnet_cidr_calculation < 2 ? 2 : local.kasm_server_subnet_cidr_calculation
  kasm_agent_subnet_id                = (var.num_webapps + 1)
}

## Will create Agent subnet x.x.0.0/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/22)
resource "aws_subnet" "kasm-db-subnet" {
  vpc_id                  = data.aws_vpc.data-kasm-default-vpc.id
  cidr_block              = cidrsubnet(var.vpc_subnet_cidr, local.kasm_server_subnet_cidr_size, 0)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-kasm-db-subnet"
  }
}

data "aws_subnet" "data-kasm_db_subnet" {
  id = aws_subnet.kasm-db-subnet.id
}

## Will create WebApp subnets x.x.1.0/24 and x.x.2.0/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/22 and 2 webapps)
resource "aws_subnet" "kasm-webapp-subnets" {
  count                   = var.num_webapps
  vpc_id                  = data.aws_vpc.data-kasm-default-vpc.id
  cidr_block              = cidrsubnet(var.vpc_subnet_cidr, local.kasm_server_subnet_cidr_size, (count.index + 1))
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-kasm-webapp-subnet"
  }
}

data "aws_subnet" "data-kasm_webapp_subnets" {
  count = var.num_webapps
  id    = aws_subnet.kasm-webapp-subnets[count.index].id
}

## Will create Agent subnet x.x.3.0/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/22)
resource "aws_subnet" "kasm-agent-subnet" {
  vpc_id                  = data.aws_vpc.data-kasm-default-vpc.id
  cidr_block              = cidrsubnet(var.vpc_subnet_cidr, local.kasm_server_subnet_cidr_size, local.kasm_agent_subnet_id)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-agent-natgw-subnet"
  }
}

data "aws_subnet" "data-kasm_agent_subnet" {
  id = aws_subnet.kasm-agent-subnet.id
}
