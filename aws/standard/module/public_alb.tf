resource "aws_lb" "kasm-alb" {
  name               = "${var.project_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.data-kasm_default_elb_sg.id]
  subnets            = data.aws_subnet.data-kasm_webapp_subnets[*].id

  access_logs {
    bucket  = data.aws_s3_bucket.data-kasm_s3_logs_bucket.bucket
    enabled = true
  }

  tags = {
    Name = "${var.project_name}-kasm-public-lb"
  }
}

data "aws_lb" "data-kasm_alb" {
  arn = aws_lb.kasm-alb.arn
}

resource "aws_lb_target_group" "kasm-target-group" {
  name     = "${var.project_name}-target-group"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.data-kasm-default-vpc.id

  health_check {
    path     = "/api/__healthcheck"
    matcher  = 200
    protocol = "HTTPS"
  }

  tags = {
    Name = "${var.project_name}-kasm-public-tg"
  }
}

data "aws_lb_target_group" "data-kasm_target_group" {
  arn = aws_lb_target_group.kasm-target-group.arn
}

resource "aws_lb_listener" "kasm-alb-listener" {
  load_balancer_arn = data.aws_lb.data-kasm_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.kasm-elb-certificate-validation.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = data.aws_lb_target_group.data-kasm_target_group.arn
  }

  tags = {
    Name = "${var.project_name}-kasm-public-https-listener"
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

  tags = {
    Name = "${var.project_name}-kasm-public-http-listener"
  }
}

resource "aws_lb_target_group_attachment" "kasm-target-group-attachment" {
  count            = var.num_webapps
  target_group_arn = data.aws_lb_target_group.data-kasm_target_group.arn
  target_id        = data.aws_instance.data-kasm_web_app[count.index].id
  port             = 443
}

resource "aws_route53_record" "kasm-route53-elb-record" {
  zone_id = data.aws_route53_zone.kasm-route53-zone.zone_id
  name    = "${var.kasm_zone_name}-lb.${var.aws_domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.kasm-alb.dns_name
    zone_id                = aws_lb.kasm-alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "kasm-app-url" {
  zone_id        = data.aws_route53_zone.kasm-route53-zone.zone_id
  name           = var.aws_domain_name
  type           = "A"
  set_identifier = "${var.project_name}-${var.kasm_zone_name}-set-id"

  alias {
    name                   = data.aws_lb.data-kasm_alb.dns_name
    zone_id                = data.aws_lb.data-kasm_alb.zone_id
    evaluate_target_health = true
  }

  latency_routing_policy {
    region = var.aws_region
  }
}

resource "aws_route53_health_check" "kasm-elb-hc" {
  fqdn              = "${var.kasm_zone_name}-lb.${var.aws_domain_name}"
  port              = 443
  type              = "HTTPS"
  resource_path     = "/api/__healthcheck"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "hc-${var.kasm_zone_name}-lb.${var.aws_domain_name}"
  }
}
