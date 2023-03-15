resource "aws_route_table" "internet_access" {
  vpc_id = data.aws_vpc.data-kasm-default-vpc.id

  route {
    cidr_block = var.anywhere
    gateway_id = data.aws_internet_gateway.data-kasm_default_ig.id
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

resource "aws_route_table_association" "agent_table_association" {
  subnet_id      = data.aws_subnet.data-kasm_agent_subnet.id
  route_table_id = data.aws_route_table.data-internet_gateway_route_table.id
}
