resource "aws_route_table" "internet_access" {
  vpc_id = data.aws_vpc.data-kasm_agent_vpc.id

  route {
    cidr_block = var.anywhere
    gateway_id = data.aws_internet_gateway.data-kasm_agent_default_ig.id
  }

  tags = {
    Name = "${var.project_name}-kasm-agent-default-route"
  }
}

data "aws_route_table" "data-agent_internet_gateway_route_table" {
  route_table_id = aws_route_table.internet_access.id
}

resource "aws_route_table_association" "agent_table_association" {
  subnet_id      = data.aws_subnet.data-kasm_agent_subnet.id
  route_table_id = data.aws_route_table.data-agent_internet_gateway_route_table.id
}
