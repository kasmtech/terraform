resource "aws_security_group" "kasm-default-sg" {
  name        = "${var.project_name}-kasm-allow-db-access"
  description = "Allow access to db"
  vpc_id      = "${aws_vpc.kasm-default-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_access_cidr}"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.kasm-webapp-subnet-1.cidr_block, aws_subnet.kasm-webapp-subnet-2.cidr_block]
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.kasm-webapp-subnet-1.cidr_block, aws_subnet.kasm-webapp-subnet-2.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-kasm-allow-db-access"
  }
}
