output "kasm_zone_name" {
  description = "The zone name used for this region/zone in Kasm"
  value       = var.aws_to_kasm_zone_map[(var.faux_aws_region)]
}
