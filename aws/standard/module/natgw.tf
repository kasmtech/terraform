resource "aws_eip" "nat_gateway_eip" {
  vpc = true
}

resource "aws_nat_gateway" "agent_and_guac_natgw" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = data.aws_subnet.data-kasm_webapp_subnets[0].id

  depends_on = [data.aws_internet_gateway.data-kasm-default-ig]
}

data "aws_nat_gateway" "data-agent_and_guac_natgw" {
  id = aws_nat_gateway.agent_and_guac_natgw.id
}
