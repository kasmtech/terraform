resource "aws_security_group" "kasm-default-elb-sg" {
  name        = "${var.project_name}-${var.zone_name}-kasm-allow-elb-access"
  description = "Security Group for ELB"
  vpc_id      = var.primary_vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-allow-access"
  }
}

resource "aws_s3_bucket" "kasm-s3-logs" {
  bucket_prefix = lower("${var.project_name}-${var.zone_name}-")
  acl           = "private"
  force_destroy = true

}

resource "aws_s3_bucket_policy" "kasm-s3-logs-policy" {
  bucket = aws_s3_bucket.kasm-s3-logs.id

  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.kasm-s3-logs.arn}/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY

}


data "aws_elb_service_account" "main" {}

resource "aws_lb" "kasm-alb" {
  name               = "${var.project_name}-${var.zone_name}-kasm-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.kasm-default-elb-sg.id}"]
  subnets            = ["${var.webapp_subnet_id_1}", "${var.webapp_subnet_id_2}"]

  access_logs {
    bucket  = aws_s3_bucket.kasm-s3-logs.bucket
    enabled = true
  }
}

resource "aws_lb_target_group" "kasm-target-group" {
  name     = "${var.project_name}-${var.zone_name}-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.primary_vpc_id

  health_check {
    path     = "/api/__healthcheck"
    matcher  = 200
    protocol = "HTTPS"
  }
}

data "aws_route53_zone" "kasm-route53-zone" {
  name         = var.aws_domain_name
  private_zone = false
}

resource "aws_lb_listener" "kasm-alb-listener" {
  load_balancer_arn = aws_lb.kasm-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kasm-target-group.arn
  }
}

resource "aws_lb_target_group_attachment" "kasm-target-group-attachment" {
  count            = var.num_webapps
  target_group_arn = aws_lb_target_group.kasm-target-group.arn
  target_id        = aws_instance.kasm-web-app[count.index].id
  port             = 443
}




resource "aws_route53_record" "kasm-route53-elb-record" {
  zone_id = data.aws_route53_zone.kasm-route53-zone.zone_id
  name    = "${var.zone_name}-lb.${var.aws_domain_name}"
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
  set_identifier = "${var.project_name}-${var.zone_name}-set-id"


  alias {
    name                   = aws_lb.kasm-alb.dns_name
    zone_id                = aws_lb.kasm-alb.zone_id
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
