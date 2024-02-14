resource "aws_security_group" "public_lb" {
  name        = "${var.project_name}-kasm-allow-public-lb-access"
  description = "Security Group for ELB"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-kasm-public-lb-access"
  }
}

resource "aws_security_group_rule" "public_lb_ingress" {
  for_each = var.public_lb_security_rules

  security_group_id = aws_security_group.public_lb.id
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = var.web_access_cidrs
}

resource "aws_security_group_rule" "public_lb_egress" {
  for_each = var.default_egress

  security_group_id = aws_security_group.public_lb.id
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_subnets
}

resource "aws_security_group" "private_lb" {
  name        = "${var.project_name}-kasm-allow-private-lb-access"
  description = "Security Group for ELB"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-kasm-private-lb-access"
  }
}

resource "aws_security_group_rule" "private_lb_egress" {
  for_each = var.private_lb_security_rules

  security_group_id = aws_security_group.private_lb.id
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = aws_subnet.webapp[*].cidr_block
}

resource "aws_security_group_rule" "private_lb_agent" {
  for_each = var.private_lb_security_rules

  security_group_id        = aws_security_group.private_lb.id
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = aws_security_group.agent.id
}

resource "aws_security_group" "webapp" {
  name        = "${var.project_name}-kasm-webapp"
  description = "Allow access to webapps"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-kasm-webapp-access"
  }
}

resource "aws_security_group_rule" "webapp_agent_ingress" {
  security_group_id        = aws_security_group.webapp.id
  type                     = "ingress"
  from_port                = var.webapp_security_rules.from_port
  to_port                  = var.webapp_security_rules.to_port
  protocol                 = var.webapp_security_rules.protocol
  source_security_group_id = aws_security_group.agent.id
}

resource "aws_security_group_rule" "webapp_private_lb_ingress" {
  security_group_id        = aws_security_group.webapp.id
  type                     = "ingress"
  from_port                = var.webapp_security_rules.from_port
  to_port                  = var.webapp_security_rules.to_port
  protocol                 = var.webapp_security_rules.protocol
  source_security_group_id = aws_security_group.private_lb.id
}

resource "aws_security_group_rule" "webapp_public_lb_ingress" {
  security_group_id        = aws_security_group.webapp.id
  type                     = "ingress"
  from_port                = var.webapp_security_rules.from_port
  to_port                  = var.webapp_security_rules.to_port
  protocol                 = var.webapp_security_rules.protocol
  source_security_group_id = aws_security_group.public_lb.id
}

resource "aws_security_group_rule" "webapp_egress" {
  for_each = var.default_egress

  security_group_id = aws_security_group.webapp.id
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_subnets
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
  source_security_group_id = aws_security_group.webapp.id
}

resource "aws_security_group_rule" "agent_egress" {
  for_each = var.default_egress

  security_group_id = aws_security_group.agent.id
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_subnets
}

resource "aws_security_group" "db" {
  name        = "${var.project_name}-kasm-db-access"
  description = "Allow access to webapps"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-kasm-db-access"
  }
}

resource "aws_security_group_rule" "db" {
  for_each = var.db_security_rules

  security_group_id        = aws_security_group.db.id
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = aws_security_group.webapp.id
}

resource "aws_security_group_rule" "db_egress" {
  for_each = var.default_egress

  security_group_id = aws_security_group.db.id
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_subnets
}

resource "aws_security_group" "cpx" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  name        = "${var.project_name}-kasm-cpx-access"
  description = "Allow access to cpx RDP nodes"
  vpc_id      = aws_vpc.this.id

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
  source_security_group_id = aws_security_group.webapp.id
}

resource "aws_security_group_rule" "private_lb_cpx" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  security_group_id        = aws_security_group.private_lb.id
  type                     = "ingress"
  from_port                = var.private_lb_security_rules.https.from_port
  to_port                  = var.private_lb_security_rules.https.to_port
  protocol                 = var.private_lb_security_rules.https.protocol
  source_security_group_id = one(aws_security_group.cpx[*].id)
}

resource "aws_security_group_rule" "webapp_cpx" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  security_group_id        = aws_security_group.webapp.id
  type                     = "ingress"
  from_port                = var.webapp_security_rules.from_port
  to_port                  = var.webapp_security_rules.to_port
  protocol                 = var.webapp_security_rules.protocol
  source_security_group_id = one(aws_security_group.cpx[*].id)
}

resource "aws_security_group_rule" "cpx_egress" {
  for_each = var.num_cpx_nodes > 0 ? var.default_egress : {}

  security_group_id = one(aws_security_group.cpx[*].id)
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_subnets
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

resource "aws_security_group_rule" "windows" {
  for_each = var.num_cpx_nodes > 0 ? var.windows_security_rules : {}

  security_group_id        = one(aws_security_group.windows[*].id)
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = can(regex("(?i:cpx)", each.key)) ? one(aws_security_group.cpx[*].id) : aws_security_group.webapp.id
}

resource "aws_security_group_rule" "private_lb_windows" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  security_group_id        = aws_security_group.private_lb.id
  type                     = "ingress"
  from_port                = var.private_lb_security_rules.https.from_port
  to_port                  = var.private_lb_security_rules.https.to_port
  protocol                 = var.private_lb_security_rules.https.protocol
  source_security_group_id = one(aws_security_group.windows[*].id)
}

resource "aws_security_group_rule" "webapp_windows" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  security_group_id        = aws_security_group.webapp.id
  type                     = "ingress"
  from_port                = var.webapp_security_rules.from_port
  to_port                  = var.webapp_security_rules.to_port
  protocol                 = var.webapp_security_rules.protocol
  source_security_group_id = one(aws_security_group.windows[*].id)
}

resource "aws_security_group_rule" "windows_egress" {
  for_each = var.num_cpx_nodes > 0 ? var.default_egress : {}

  security_group_id = one(aws_security_group.windows[*].id)
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_subnets
}
