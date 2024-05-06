## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
## Service Account details
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
output "connect_details" {
  description = "Kasm autoscale service account connect JSON output. NOTE: This contains sensitive data!"
  value       = google_service_account_key.kasm_key.private_key
  sensitive   = true
}
