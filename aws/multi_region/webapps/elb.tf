data "aws_route53_zone" "kasm-route53-zone" {
  name         = var.aws_domain_name
  private_zone = false
}

resource "aws_lb" "kasm-alb" {
  name               = "${var.project_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.load_balancer_security_group_id]
  subnets            = var.webapp_subnet_ids

  access_logs {
    bucket  = var.load_balancer_log_bucket
    enabled = true
  }
}

data "aws_lb" "data-kasm_alb" {
  arn = aws_lb.kasm-alb.arn
}

resource "aws_lb_target_group" "kasm-target-group" {
  name     = "${var.project_name}-target-group"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.primary_vpc_id

  health_check {
    path     = "/api/__healthcheck"
    matcher  = 200
    protocol = "HTTPS"
  }
}

data "aws_lb_target_group" "data-kasm_target_group" {
  arn = aws_lb_target_group.kasm-target-group.arn
}

resource "aws_lb_listener" "kasm-alb-listener" {
  load_balancer_arn = data.aws_lb.data-kasm_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = data.aws_lb_target_group.data-kasm_target_group.arn
  }
}

resource "aws_lb_listener" "kasm_alb_listener_http" {
  load_balancer_arn = data.aws_lb.data-kasm_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group_attachment" "kasm-target-group-attachment" {
  count            = var.num_webapps
  target_group_arn = data.aws_lb_target_group.data-kasm_target_group.arn
  target_id        = data.aws_instance.data-kasm_web_apps[count.index].id
  port             = 443
}

resource "aws_route53_record" "kasm-route53-elb-record" {
  zone_id = data.aws_route53_zone.kasm-route53-zone.zone_id
  name    = "${var.zone_name}-lb.${var.aws_domain_name}"
  type    = "A"

  alias {
    name                   = data.aws_lb.data-kasm_alb.dns_name
    zone_id                = data.aws_lb.data-kasm_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "kasm-app-url" {
  zone_id        = data.aws_route53_zone.kasm-route53-zone.zone_id
  name           = var.aws_domain_name
  type           = "A"
  set_identifier = "${var.project_name}-${var.zone_name}-set-id"

  alias {
    name                   = data.aws_lb.data-kasm_alb.dns_name
    zone_id                = data.aws_lb.data-kasm_alb.zone_id
    evaluate_target_health = true
  }

  latency_routing_policy {
    region = var.faux_aws_region
  }
}

resource "aws_route53_health_check" "kasm-elb-hc" {
  fqdn              = "${var.zone_name}-lb.${var.aws_domain_name}"
  port              = 443
  type              = "HTTPS"
  resource_path     = "/api/__healthcheck"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "hc-${var.zone_name}-lb.${var.aws_domain_name}"
  }
}
