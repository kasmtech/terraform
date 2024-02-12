output "kasm_zone_settings" {
  description = "Upstream Auth and Proxy Address settings to apply to Kasm Zone configuration"
  value       = <<ZONE
Kam Zone configuration for zone: ${var.faux_aws_region}
Upstream Auth address: ${var.aws_domain_name}
Proxy address: ${var.zone_name}-lb.${var.aws_domain_name}
ZONE
}
