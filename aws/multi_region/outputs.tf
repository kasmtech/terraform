output "region1_zone_settings" {
  description = "Upstream Auth and Proxy settings to apply to Kasm Primary Region Zone configuration"
  value       = <<ZONE
Kam Zone configuration for zone: ${module.primary_region_webapps_and_agents.kasm_zone_name}
Upstream Auth address:           ${var.aws_domain_name}
Proxy address:                   ${join("", slice(split("-", var.aws_primary_region), 1, 3))}-lb.${var.aws_domain_name}
ZONE
}

output "region2_zone_settings" {
  description = "Upstream Auth and Proxy settings to apply to Kasm Agent Region 2 Zone configuration"
  value       = <<ZONE
Kam Zone configuration for zone: ${module.primary_region_webapps_and_agents.kasm_zone_name}
Upstream Auth address:           ${var.aws_domain_name}
Proxy address:                   ${join("", slice(split("-", var.secondary_regions_settings.region2.agent_region), 1, 3))}-proxy.${var.aws_domain_name}
ZONE
}

output "ssh_keys" {
  description = "SSH Keys to be used with your Kasm Deployment"
  value       = module.ssh_keys.ssh_key_info
}
#########################################################################
#
# Uncomment the below section and update the provider and the settings
# in the secondary_regions_settings variable in the terraform.tfvars
# file for your desired region.
#
#########################################################################
# output "region3_zone_settings" {
#   description = "Upstream Auth and Proxy settings to apply to Kasm Agent Region 3 Zone configuration"
#   value       = <<ZONE
# Kam Zone configuration for zone: default
# Upstream Auth address:    ${var.aws_domain_name}
# Proxy address:            ${join("", slice(split("-", var.secondary_regions_settings.region3.agent_region), 1, 3))}-proxy.${var.aws_domain_name}
# ZONE
# }
