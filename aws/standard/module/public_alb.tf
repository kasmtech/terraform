resource "aws_lb" "public" {
  name               = "${var.project_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_lb.id]
  subnets            = aws_subnet.alb[*].id

  access_logs {
    bucket  = aws_s3_bucket.this.bucket
    enabled = true
  }

  tags = {
    Name = "${var.project_name}-kasm-public-lb"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.public.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.this.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public.arn
  }

  tags = {
    Name = "${var.project_name}-kasm-public-https-listener"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.public.arn
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

resource "aws_lb_target_group" "public" {
  name     = "${var.project_name}-target-group"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.this.id

  health_check {
    path     = "/api/__healthcheck"
    matcher  = 200
    protocol = "HTTPS"
  }

  tags = {
    Name = "${var.project_name}-kasm-public-tg"
  }
}

resource "aws_lb_target_group_attachment" "public" {
  count = var.num_webapps

  target_group_arn = aws_lb_target_group.public.arn
  target_id        = aws_instance.webapp[count.index].id
  port             = 443
}

resource "aws_route53_record" "public" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.aws_domain_name
  type    = "A"

  alias {
    name                   = aws_lb.public.dns_name
    zone_id                = aws_lb.public.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_health_check" "kasm-elb-hc" {
  fqdn              = var.aws_domain_name
  port              = 443
  type              = "HTTPS"
  resource_path     = "/api/__healthcheck"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "hc-${var.aws_domain_name}"
  }
}
