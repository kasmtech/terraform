resource "google_dns_record_set" "records" {
  project      = var.project_id
  managed_zone = var.name

  for_each = { for record in var.recordsets : join("/", [record.name, record.type]) => record }
  name     = (each.value.name != "" ? "${each.value.name}.${var.domain}." : "${var.domain}.")
  type     = each.value.type
  ttl      = each.value.ttl

  rrdatas = each.value.records
}
