resource "aws_subnet" "alb" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.agent_vpc_cidr, local.kasm_agent_subnet_cidr_size, count.index)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.aws_region}-kasm-alb-subnet"
  }
}

resource "aws_subnet" "proxy" {
  count             = var.num_proxy_nodes
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.agent_vpc_cidr, local.kasm_agent_subnet_cidr_size, (count.index + 2))
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project_name}-${var.aws_region}-kasm-proxy-subnet"
  }
}

resource "aws_subnet" "agent" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.agent_vpc_cidr, local.kasm_agent_subnet_cidr_size, 4)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.aws_region}-kasm-agent-subnet"
  }
}

resource "aws_subnet" "cpx" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.agent_vpc_cidr, local.kasm_agent_subnet_cidr_size, 5)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project_name}-${var.aws_region}-kasm-cpx-subnet"
  }
}

resource "aws_subnet" "windows" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.agent_vpc_cidr, local.kasm_agent_subnet_cidr_size, 6)
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.aws_region}-kasm-windows-subnet"
  }
}

