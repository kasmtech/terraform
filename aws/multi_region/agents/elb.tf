resource "aws_lb" "this" {
  name               = "${var.project_name}-${var.aws_region}-proxy-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_lb.id]
  subnets            = aws_subnet.alb[*].id
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.this.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.project_name}-${local.region_short_name_for_lb}-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.this.id

  health_check {
    path     = "/desktop"
    matcher  = 301
    protocol = "HTTPS"
  }
}

resource "aws_lb_target_group_attachment" "this" {
  count = var.num_proxy_nodes

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.proxy[count.index].id
  port             = 443
}

resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "${local.region_short_name_for_lb}-proxy.${var.aws_domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = false
  }
}
