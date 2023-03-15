resource "aws_security_group" "kasm-agent-sg" {
  name        = "${var.project_name}-${var.zone_name}-kasm-agent-access"
  description = "Allow access to agents"
  vpc_id      = data.aws_vpc.data-kasm_agent_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_access_cidrs
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.anywhere]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.anywhere]
  }
}

data "aws_security_group" "data-kasm_agent_sg" {
  id = aws_security_group.kasm-agent-sg.id
}
