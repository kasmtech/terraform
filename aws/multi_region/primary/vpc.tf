resource "aws_vpc" "kasm-default-vpc" {
  cidr_block           = var.vpc_subnet_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project_name}-kasm-db-vpc"
  }
}

data "aws_vpc" "data-kasm-default-vpc" {
  id = aws_vpc.kasm-default-vpc.id
}

resource "aws_internet_gateway" "kasm-default-ig" {
  vpc_id = aws_vpc.kasm-default-vpc.id
  tags = {
    Name = "${var.project_name}-kasm-ig"
  }
}

data "aws_internet_gateway" "data-kasm_default_ig" {
  internet_gateway_id = aws_internet_gateway.kasm-default-ig.id
}
