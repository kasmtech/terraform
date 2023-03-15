resource "aws_route_table" "internet_access" {
  vpc_id = data.aws_vpc.data-kasm-default-vpc.id

  route {
    cidr_block = var.anywhere
    gateway_id = data.aws_internet_gateway.data-kasm-default-ig.id
  }

  tags = {
    Name = "${var.project_name}-kasm-default-route"
  }
}

data "aws_route_table" "data-internet_gateway_route_table" {
  route_table_id = aws_route_table.internet_access.id
}

resource "aws_route_table_association" "webapp_route_association" {
  count          = var.num_webapps
  subnet_id      = data.aws_subnet.data-kasm_webapp_subnets[count.index].id
  route_table_id = data.aws_route_table.data-internet_gateway_route_table.id
}

resource "aws_route_table_association" "db_route_association" {
  subnet_id      = data.aws_subnet.data-kasm_db_subnet.id
  route_table_id = data.aws_route_table.data-internet_gateway_route_table.id
}

resource "aws_route_table" "nat_route_table" {
  vpc_id = data.aws_vpc.data-kasm-default-vpc.id

  route {
    cidr_block = var.anywhere
    gateway_id = data.aws_nat_gateway.data-agent_and_guac_natgw.id
  }

  tags = {
    Name = "${var.project_name}-kasm-natgw-route"
  }
}

data "aws_route_table" "data-nat_route_table" {
  route_table_id = aws_route_table.nat_route_table.id
}

resource "aws_route_table_association" "agent_nat_route_table_association" {
  subnet_id      = data.aws_subnet.data-kasm_agent_subnet.id
  route_table_id = data.aws_route_table.data-nat_route_table.id
}

resource "aws_route_table_association" "guac_nat_route_table_association" {
  subnet_id      = data.aws_subnet.data-kasm_guac_subnet.id
  route_table_id = data.aws_route_table.data-nat_route_table.id
}
