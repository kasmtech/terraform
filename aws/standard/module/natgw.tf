resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat_gateway_eip.id}"
  subnet_id     = "${aws_subnet.kasm-agent-subnet.id}"
}

resource "aws_eip" "nat_gateway_eip" {
  vpc = true
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.kasm-default-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.kasm-use-natgw-subnet.id
  route_table_id = aws_route_table.r.id
}