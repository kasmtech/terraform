output "kasm_zone_settings" {
  description = "Upstream Auth settings to apply to Kasm Zone configuration"
  value       = <<ZONE
Kam Zone configuration for zone: default
Upstream Auth address:           ${var.aws_region}-private.${var.aws_domain_name}
ZONE
}
