resource "aws_vpc" "kasm-default-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.project_name}-kasm-db-vpc"
  }
}

resource "aws_internet_gateway" "kasm-default-ig" {
  vpc_id = "${aws_vpc.kasm-default-vpc.id}"
  tags = {
    Name = "${var.project_name}-kasm-ig"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.kasm-default-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.kasm-default-ig.id}"
}


output "primary_vpc_id" {
  value = "${aws_vpc.kasm-default-vpc.id}"
}

