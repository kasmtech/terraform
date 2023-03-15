resource "aws_acm_certificate" "kasm-alb-cert" {
  domain_name               = var.aws_domain_name
  subject_alternative_names = ["*.${var.aws_domain_name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "kasm-route53-cert-validation-record" {
  for_each = {
    for dvo in aws_acm_certificate.kasm-alb-cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  zone_id = data.aws_route53_zone.kasm-route53-zone.id

  ttl             = 30
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "kasm-elb-certificate-validation" {
  certificate_arn         = aws_acm_certificate.kasm-alb-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.kasm-route53-cert-validation-record : record.fqdn]
}
