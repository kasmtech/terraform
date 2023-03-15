resource "tls_private_key" "registration_private_key" {
  algorithm = "RSA"
}

resource "tls_private_key" "certificate_private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.registration_private_key.private_key_pem
  email_address   = var.letsencrypt_cert_support_email
}

resource "tls_cert_request" "kasm_certificate_request" {
  private_key_pem = tls_private_key.certificate_private_key.private_key_pem
  dns_names       = [data.oci_dns_zones.kasm_dns_zone.zones[0].name, "*.${data.oci_dns_zones.kasm_dns_zone.zones[0].name}"]

  subject {
    common_name = data.oci_dns_zones.kasm_dns_zone.zones[0].name
  }
}

resource "acme_certificate" "certificate" {
  account_key_pem         = acme_registration.registration.account_key_pem
  certificate_request_pem = tls_cert_request.kasm_certificate_request.cert_request_pem
  recursive_nameservers = [
    "8.8.8.8:53",
    "4.4.2.2:53"
  ]

  dns_challenge {
    provider = "oraclecloud"

    config = {
      OCI_COMPARTMENT_OCID    = var.compartment_ocid
      OCI_PRIVKEY_FILE        = var.private_key_path
      OCI_TENANCY_OCID        = var.tenancy_ocid
      OCI_REGION              = var.region
      OCI_PUBKEY_FINGERPRINT  = var.fingerprint
      OCI_USER_OCID           = var.user_ocid
      OCI_PROPOGATION_TIMEOUT = 600
      OCI_POLLING_INTERVAL    = 60
      OCI_TTL                 = 300
    }
  }

  depends_on = [acme_registration.registration]
}
