resource "aws_subnet" "kasm-database-subnet" {
  vpc_id                  = "${aws_vpc.kasm-default-vpc.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-kasm-subnet"
  }
}

resource "aws_subnet" "kasm-webapp-subnet-1" {
  vpc_id                  = "${aws_vpc.kasm-default-vpc.id}"
  cidr_block              = "10.0.20.0/24"
  availability_zone       = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-kasm-webapp-subnet-1"
  }
}



resource "aws_subnet" "kasm-webapp-subnet-2" {
  vpc_id                  = "${aws_vpc.kasm-default-vpc.id}"
  cidr_block              = "10.0.30.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-kasm-webapp-subnet-2"
  }
}

resource "aws_subnet" "kasm-agent-subnet" {
  vpc_id                  = "${aws_vpc.kasm-default-vpc.id}"
  cidr_block              = "10.0.40.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-kasm-webapp-subnet-2"
  }
}


output "webapp_subnet_1_id" {
  value = "${aws_subnet.kasm-webapp-subnet-1.id}"
}


output "webapp_subnet_2_id" {
  value = "${aws_subnet.kasm-webapp-subnet-2.id}"
}

output "agent_subnet_id" {
  value = "${aws_subnet.kasm-agent-subnet.id}"
}