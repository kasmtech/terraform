resource "aws_lb" "private" {
  name               = "${var.project_name}-private-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.private_lb.id]
  subnets            = aws_subnet.webapp[*].id

  access_logs {
    bucket  = aws_s3_bucket.this.bucket
    enabled = true
  }

  tags = {
    Name = "${var.project_name}-kasm-private-lb"
  }
}

resource "aws_lb_target_group" "private" {
  name     = "${var.project_name}-private-target-group"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.this.id

  health_check {
    path     = "/api/__healthcheck"
    matcher  = 200
    protocol = "HTTPS"
  }

  tags = {
    Name = "${var.project_name}-kasm-private-tg"
  }
}

resource "aws_lb_listener" "private" {
  load_balancer_arn = aws_lb.private.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.this.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private.arn
  }

  tags = {
    Name = "${var.project_name}-kasm-private-https-listener"
  }
}

resource "aws_lb_target_group_attachment" "private" {
  count = var.num_webapps

  target_group_arn = aws_lb_target_group.private.arn
  target_id        = aws_instance.webapp[count.index].id
  port             = 443
}

resource "aws_route53_record" "private" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = local.private_lb_hostname
  type    = "A"

  alias {
    name                   = aws_lb.private.dns_name
    zone_id                = aws_lb.private.zone_id
    evaluate_target_health = true
  }
}
