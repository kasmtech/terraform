resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = var.account_id
  display_name = var.display_name
}

resource "google_service_account_key" "kasm_key" {
  service_account_id = google_service_account.service_account.id
}

module "service_account_roles" {
  source  = "terraform-google-modules/iam/google//modules/member_iam"
  version = "~> 7.6"

  service_account_address = google_service_account.service_account.email
  project_id              = var.project_id
  project_roles           = ["roles/compute.instanceAdmin", "roles/iam.serviceAccountUser"]
  prefix                  = "serviceAccount"
}

module "dns_zone_admin" {
  source  = "terraform-google-modules/iam/google//modules/dns_zones_iam"
  version = "~> 7.6"
  count   = var.manage_dns ? 1 : 0

  project       = var.project_id
  managed_zones = [var.dns_public_zone_name]
  mode          = "additive"
  bindings = {
    "roles/dns.admin" = [
      "serviceAccount:${google_service_account.service_account.email}"
    ]
  }
}
