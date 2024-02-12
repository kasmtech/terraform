resource "aws_security_group" "public_lb" {
  name        = "${var.project_name}-kasm-allow-public-lb-access"
  description = "Security Group for ELB"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-kasm-public-lb-access"
  }
}

resource "aws_security_group_rule" "public_lb" {
  for_each = var.public_lb_security_rules

  security_group_id = aws_security_group.public_lb.id
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [var.anywhere]
}

resource "aws_security_group" "proxy" {
  name        = "${var.project_name}-kasm-proxy"
  description = "Allow access to proxy"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-kasm-proxy-access"
  }
}

resource "aws_security_group_rule" "proxy" {
  for_each = local.proxy_security_rules

  security_group_id        = aws_security_group.proxy.id
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = each.key
}

resource "aws_security_group" "agent" {
  name        = "${var.project_name}-kasm-agent-access"
  description = "Allow access to agents"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-kasm-agent-access"
  }
}

resource "aws_security_group_rule" "agent" {
  for_each = var.agent_security_rules

  security_group_id        = aws_security_group.agent.id
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = aws_security_group.proxy.id
}

resource "aws_security_group" "cpx" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  name        = "${var.project_name}-kasm-cpx-access"
  description = "Allow access to cpx RDP nodes"

  tags = {
    Name = "${var.project_name}-kasm-cpx-access"
  }
}

resource "aws_security_group_rule" "cpx" {
  for_each = var.num_cpx_nodes > 0 ? var.cpx_security_rules : {}

  security_group_id        = one(aws_security_group.cpx[*].id)
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = aws_security_group.proxy.id
}

resource "aws_security_group" "windows" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  name        = "${var.project_name}-kasm-windows-access"
  description = "Allow access to Windows servers"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-kasm-windows-access"
  }
}

resource "aws_security_group_rule" "windows_cpx" {
  for_each = var.num_cpx_nodes > 0 ? var.windows_security_rules : {}

  security_group_id        = one(aws_security_group.windows[*].id)
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = one(aws_security_group.cpx[*].id)
}

resource "aws_security_group_rule" "windows_webapp" {
  for_each = var.num_cpx_nodes > 0 ? { for key, value in var.windows_security_rules : key => value if can(regex("(?i:api)", key)) } : {}

  security_group_id = one(aws_security_group.windows[*].id)
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [var.management_region_nat_gateway]
}

resource "aws_security_group_rule" "egress" {
  for_each = { for value in local.all_security_groups : value => var.default_egress }

  security_group_id = each.key
  type              = each.value.rule_type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [var.anywhere]
}
