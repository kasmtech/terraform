output "certificate_map_id" {
  description = "The value of the generated certificate map for use with the external load balancer"
  value       = google_certificate_manager_certificate_map.cert_map.id
}
