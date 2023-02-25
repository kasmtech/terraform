resource "aws_subnet" "kasm-db-subnet" {
  vpc_id                                      = aws_vpc.kasm-default-vpc.id
  cidr_block                                  = "10.${var.master_subnet_id}.10.0/24"
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true
  availability_zone                           = "us-east-1d"
  tags = {
    Name = "${var.project_name}-kasm-db-subnet"
  }
}

resource "aws_subnet" "kasm-webapp-subnet" {
  vpc_id                                      = aws_vpc.kasm-default-vpc.id
  cidr_block                                  = "10.${var.master_subnet_id}.20.0/24"
  availability_zone                           = "us-east-1c"
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true
  tags = {
    Name = "${var.project_name}-kasm-webapp-subnet"
  }
}

resource "aws_subnet" "kasm-webapp-subnet-2" {
  vpc_id                                      = aws_vpc.kasm-default-vpc.id
  cidr_block                                  = "10.${var.master_subnet_id}.30.0/24"
  availability_zone                           = "us-east-1b"
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true
  tags = {
    Name = "${var.project_name}-kasm-webapp-subnet"
  }
}


resource "aws_subnet" "kasm-agent-subnet" {
  vpc_id                                      = aws_vpc.kasm-default-vpc.id
  cidr_block                                  = "10.${var.master_subnet_id}.40.0/24"
  availability_zone                           = "us-east-1b"
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true

  tags = {
    Name = "${var.project_name}-kasm-agent-subnet"
  }
}


resource "aws_subnet" "kasm-use-natgw-subnet" {
  vpc_id                                      = aws_vpc.kasm-default-vpc.id
  cidr_block                                  = "10.${var.master_subnet_id}.50.0/24"
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true
  availability_zone                           = "us-east-1b"
  tags = {
    Name = "${var.project_name}-natgw-kasm-subnet"
  }
}
