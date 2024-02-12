resource "aws_lb" "this" {
  name               = "${var.project_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.load_balancer_security_group_id]
  subnets            = var.load_balancer_subnet_ids

  access_logs {
    bucket  = var.load_balancer_log_bucket
    enabled = true
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
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

resource "aws_lb_target_group" "this" {
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
resource "aws_lb_target_group_attachment" "this" {
  count = var.num_webapps

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.webapp[count.index].id
  port             = 443
}

resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "${var.zone_name}-lb.${var.aws_domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "latency" {
  zone_id        = data.aws_route53_zone.this.zone_id
  name           = var.aws_domain_name
  type           = "A"
  set_identifier = "${var.project_name}-${var.zone_name}-set-id"

  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }

  latency_routing_policy {
    region = var.faux_aws_region
  }
}

resource "aws_route53_health_check" "this" {
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
