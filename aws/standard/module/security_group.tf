resource "aws_security_group" "kasm-default-elb-sg" {
  name        = "${var.project_name}-kasm-allow-elb-access"
  description = "Security Group for ELB"
  vpc_id      = aws_vpc.kasm-default-vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-kasm-allow-access"
  }
}




resource "aws_security_group" "kasm-webapp-sg" {
  name        = "${var.project_name}-${var.zone_name}-kasm-webapp"
  description = "Allow access to webapps"
  vpc_id      = aws_vpc.kasm-default-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_access_cidr}"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.kasm-default-elb-sg.id}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.kasm-agent-subnet.cidr_block}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.kasm-use-natgw-subnet.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}






resource "aws_security_group" "kasm-agent-sg" {
  name        = "${var.project_name}-${var.zone_name}-kasm-agent-access"
  description = "Allow access to agents"
  vpc_id      = aws_vpc.kasm-default-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_access_cidr}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.kasm-webapp-subnet.cidr_block}", "${aws_subnet.kasm-webapp-subnet-2.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_security_group" "kasm-db-sg" {
  name        = "${var.project_name}-${var.zone_name}-kasm-db-access"
  description = "Allow access to webapps"
  vpc_id      = aws_vpc.kasm-default-vpc.id

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
    cidr_blocks = ["${aws_subnet.kasm-webapp-subnet.cidr_block}"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.kasm-use-natgw-subnet.cidr_block}"]
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.kasm-webapp-subnet.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "kasm-nfs-sg" {
  name        = "${var.project_name}-kasm-nfs-access"
  description = "Security Group for NFS"
  vpc_id      = aws_vpc.kasm-default-vpc.id

  ingress {
    from_port   = 111
    to_port     = 111
    protocol    = "tcp"
    cidr_blocks = ["10.${var.master_subnet_id}.0.0/16"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.${var.master_subnet_id}.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-kasm-nfs-access"
  }
}

resource "aws_security_group" "kasm-fsx-sg" {
  name        = "${var.project_name}-kasm-fsx-access"
  description = "Security Group for NFS"
  vpc_id      = aws_vpc.kasm-default-vpc.id

  ingress {
    from_port   = 0
    to_port     = 65000
    protocol    = "tcp"
    cidr_blocks = ["10.${var.master_subnet_id}.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-kasm-fsx-access"
  }
}
