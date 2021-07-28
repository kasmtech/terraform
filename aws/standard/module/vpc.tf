# Create a VPC to launch our instances into
resource "aws_vpc" "kasm-default-vpc" {
  cidr_block = "10.${var.master_subnet_id}.0.0/16"
  tags = {
    Name = "${var.project_name}-kasm-db-vpc"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "kasm-default-ig" {
  vpc_id = "${aws_vpc.kasm-default-vpc.id}"
  tags = {
    Name = "${var.project_name}-kasm-ig"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.kasm-default-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.kasm-default-ig.id}"
}



