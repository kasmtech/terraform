resource "aws_route_table" "internet_gateway" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.anywhere
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.project_name}-kasm-internet-gateway-route"
  }
}

resource "aws_route_table" "nat_gateway" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = var.anywhere
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "${var.project_name}-kasm-nat-gateway-route"
  }
}

resource "aws_route_table_association" "alb" {
  count          = 2
  subnet_id      = aws_subnet.alb[(count.index)].id
  route_table_id = aws_route_table.internet_gateway.id
}

resource "aws_route_table_association" "proxy" {
  count          = var.num_proxy_nodes
  subnet_id      = aws_subnet.proxy[(count.index)].id
  route_table_id = aws_route_table.nat_gateway.id
}

resource "aws_route_table_association" "agent" {
  subnet_id      = aws_subnet.agent.id
  route_table_id = aws_route_table.internet_gateway.id
}

resource "aws_route_table_association" "cpx" {
  count          = var.num_cpx_nodes > 0 ? 1 : 0
  subnet_id      = aws_subnet.cpx[0].id
  route_table_id = aws_route_table.nat_gateway.id
}

resource "aws_route_table_association" "windows" {
  count          = var.num_cpx_nodes > 0 ? 1 : 0
  subnet_id      = aws_subnet.windows[0].id
  route_table_id = aws_route_table.internet_gateway.id
}
