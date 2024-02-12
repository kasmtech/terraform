data "aws_route53_zone" "this" {
  name         = var.aws_domain_name
  private_zone = false
}
