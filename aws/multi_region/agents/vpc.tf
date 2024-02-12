resource "aws_vpc" "this" {
  cidr_block           = var.agent_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-${var.aws_region}-kasm-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-${var.aws_region}-kasm-ig"
  }
}

resource "aws_eip" "this" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.alb[0].id

  tags = {
    Name = "${var.project_name}-${var.aws_region}-kasm-nat"
  }

  depends_on = [aws_internet_gateway.this]
}
