## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
## Service Account details
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
output "kasm_sa_account" {
  description = "Kasm Service Account connection details"
  value       = var.show_sa_credentials ? module.kasm_autoscale_service_account[*].connect_details : null
  sensitive   = true
}

output "kasm_passwords" {
  description = "Kasm login passwords"
  value = var.show_passwords ? {
    kasm_admin_password    = local.admin_password
    kasm_user_password     = local.user_password
    kasm_database_password = local.database_password
    kasm_redis_password    = local.redis_password
    kasm_service_token     = local.service_token
    kasm_manager_token     = local.manager_token
  } : null
  sensitive = true
}
