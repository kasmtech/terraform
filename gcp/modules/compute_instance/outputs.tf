## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
## Deploy Ksam Database
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
output "private_ip" {
  description = "Instance private IP address."
  value       = google_compute_instance.kasm_instance[*].network_interface[0].network_ip
}

output "public_ip" {
  description = "Instance public IP address (if applicable)"
  value       = google_compute_instance.kasm_instance[*].network_interface[0].access_config
}
