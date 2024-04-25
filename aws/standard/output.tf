output "kasm_zone_settings" {
  description = "Upstream Auth settings to apply to Kasm Zone configuration"
  value       = <<ZONE
Kam Zone configuration for zone: default
Upstream Auth address:           ${var.aws_region}-private.${var.aws_domain_name}
ZONE
}

output "ssh_key_info" {
  description = "SSH Keys to use with Kasm Deployment"
  value       = module.standard.ssh_key_info
  sensitive   = true
}
