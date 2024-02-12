resource "aws_route_table" "ig" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.anywhere
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.project_name}-kasm-default-route"
  }
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.anywhere
    gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "${var.project_name}-kasm-natgw-route"
  }
}

resource "aws_route_table_association" "alb" {
  count = 2

  subnet_id      = aws_subnet.alb[count.index].id
  route_table_id = aws_route_table.ig.id
}

resource "aws_route_table_association" "webapp" {
  count = var.num_webapps

  subnet_id      = aws_subnet.webapp[count.index].id
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table_association" "db" {
  subnet_id      = aws_subnet.db.id
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table_association" "cpx" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  subnet_id      = one(aws_subnet.cpx[*].id)
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table_association" "agent" {
  subnet_id      = aws_subnet.agent.id
  route_table_id = aws_route_table.ig.id
}

resource "aws_route_table_association" "windows" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  subnet_id      = one(aws_subnet.windows[*].id)
  route_table_id = aws_route_table.ig.id
}
