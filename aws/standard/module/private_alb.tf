locals {
  private_lb_hostname = "${var.kasm_zone_name}-private-lb.${var.aws_domain_name}"
}

resource "aws_lb" "kasm-private-alb" {
  name               = "${var.project_name}-private-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.data-kasm_default_elb_sg.id]
  subnets            = data.aws_subnet.data-kasm_webapp_subnets[*].id

  access_logs {
    bucket  = data.aws_s3_bucket.data-kasm_s3_logs_bucket.bucket
    enabled = true
  }

  tags = {
    Name = "${var.project_name}-kasm-private-lb"
  }
}

data "aws_lb" "data-kasm_private_alb" {
  arn = aws_lb.kasm-private-alb.arn
}

resource "aws_lb_target_group" "kasm-private-target-group" {
  name     = "${var.project_name}-private-target-group"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.data-kasm-default-vpc.id

  health_check {
    path     = "/api/__healthcheck"
    matcher  = 200
    protocol = "HTTPS"
  }

  tags = {
    Name = "${var.project_name}-kasm-private-tg"
  }
}

data "aws_lb_target_group" "data-kasm_private_target_group" {
  arn = aws_lb_target_group.kasm-private-target-group.arn
}

resource "aws_lb_listener" "kasm-private-alb-listener" {
  load_balancer_arn = data.aws_lb.data-kasm_private_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.kasm-elb-certificate-validation.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = data.aws_lb_target_group.data-kasm_private_target_group.arn
  }

  tags = {
    Name = "${var.project_name}-kasm-private-https-listener"
  }
}

resource "aws_lb_target_group_attachment" "kasm-private-target-group-attachment" {
  count            = var.num_webapps
  target_group_arn = data.aws_lb_target_group.data-kasm_private_target_group.arn
  target_id        = data.aws_instance.data-kasm_web_app[count.index].id
  port             = 443
}

resource "aws_route53_record" "kasm-route53-private-elb-record" {
  zone_id = data.aws_route53_zone.kasm-route53-zone.zone_id
  name    = local.private_lb_hostname
  type    = "A"

  alias {
    name                   = data.aws_lb.data-kasm_private_alb.dns_name
    zone_id                = data.aws_lb.data-kasm_private_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_health_check" "kasm-private-elb-hc" {
  fqdn              = local.private_lb_hostname
  port              = 443
  type              = "HTTPS"
  resource_path     = "/api/__healthcheck"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "hc-${var.kasm_zone_name}-private-lb.${var.aws_domain_name}"
  }
}
