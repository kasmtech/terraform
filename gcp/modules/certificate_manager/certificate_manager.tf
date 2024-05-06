resource "google_certificate_manager_dns_authorization" "cert_auth" {
  name        = var.certificate_dns_authorization_name
  description = var.certificate_dns_authorization_description
  domain      = var.domain_name
  labels      = var.resource_labels
}

resource "google_dns_record_set" "cert_dns_record" {
  name         = google_certificate_manager_dns_authorization.cert_auth.dns_resource_record[0].name
  type         = "CNAME"
  ttl          = 30
  managed_zone = var.dns_managed_zone_name
  rrdatas      = [google_certificate_manager_dns_authorization.cert_auth.dns_resource_record[0].data]
}

resource "google_certificate_manager_certificate" "cert" {
  name        = var.certificate_name
  description = var.certificate_description
  scope       = var.certificate_scope
  labels      = var.resource_labels

  managed {
    domains = compact([
      google_certificate_manager_dns_authorization.cert_auth.domain,
      var.create_wildcard ? "*.${google_certificate_manager_dns_authorization.cert_auth.domain}" : ""
    ])
    dns_authorizations = [
      google_certificate_manager_dns_authorization.cert_auth.id
    ]
  }

  depends_on = [google_dns_record_set.cert_dns_record]
}

resource "google_certificate_manager_certificate_map" "cert_map" {
  name        = var.certificate_map_name
  description = var.certificate_map_description
  labels      = var.resource_labels
}

resource "google_certificate_manager_certificate_map_entry" "cert_map_entry" {
  name         = "${var.certificate_map_name}-entry"
  map          = google_certificate_manager_certificate_map.cert_map.name
  certificates = [google_certificate_manager_certificate.cert.id]
  matcher      = "PRIMARY"
  labels       = var.resource_labels
}
