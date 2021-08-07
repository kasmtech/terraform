resource "aws_subnet" "kasm-agent-subnet" {
  vpc_id                  = "${aws_vpc.kasm-default-vpc.id}"
  cidr_block              = "10.0.40.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-agent-subnet"
  }
}