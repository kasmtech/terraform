locals {
  kasm_vpc_subnet_cidr_mask           = split("/", var.vpc_subnet_cidr)[1]
  kasm_server_subnet_cidr_calculation = (8 - (local.kasm_vpc_subnet_cidr_mask - 16))
  kasm_server_subnet_cidr_size        = local.kasm_server_subnet_cidr_calculation < 3 ? 3 : local.kasm_server_subnet_cidr_calculation
}

## Will create Agent subnet x.x.0.0/24 and x.x.1.0/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "aws_subnet" "alb" {
  count = 2

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_subnet_cidr, local.kasm_server_subnet_cidr_size, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-kasm-lb-subnet-${count.index}"
  }
}

## Will create WebApp subnets x.x.2.0/24 and x.x.3.0/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "aws_subnet" "webapp" {
  count = var.num_webapps

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_subnet_cidr, local.kasm_server_subnet_cidr_size, (count.index + 2))
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project_name}-kasm-webapp-subnet-${count.index}"
  }
}

## Will create Agent subnet x.x.4.0/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_subnet_cidr, local.kasm_server_subnet_cidr_size, 4)
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.project_name}-kasm-db-subnet"
  }
}

## Will create Agent subnet x.x.6.0/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "aws_subnet" "agent" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_subnet_cidr, local.kasm_server_subnet_cidr_size, 5)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.project_name}-agent-subnet"
  }
}

## Will create CPX subnet x.x.5.0/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "aws_subnet" "cpx" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.vpc_subnet_cidr, local.kasm_server_subnet_cidr_size, 6)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project_name}-cpx-subnet"
  }
}

## Will create cpx subnet x.x.7.0/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "aws_subnet" "windows" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.vpc_subnet_cidr, local.kasm_server_subnet_cidr_size, 7)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.project_name}-windows-subnet"
  }
}
