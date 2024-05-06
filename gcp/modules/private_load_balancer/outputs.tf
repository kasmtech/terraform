output "ip_address" {
  description = "The internal IP assigned to the regional forwarding rule."
  value       = google_compute_forwarding_rule.default.ip_address
}

output "forwarding_rule" {
  description = "The forwarding rule self_link."
  value       = google_compute_forwarding_rule.default.self_link
}

output "forwarding_rule_id" {
  description = "The forwarding rule id."
  value       = google_compute_forwarding_rule.default.id
}
