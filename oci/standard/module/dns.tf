data "oci_dns_zones" "kasm_dns_zone" {
  compartment_id = var.compartment_ocid
  name           = var.oci_domain_name
}

resource "oci_dns_rrset" "kasm_a_record" {
  compartment_id  = var.compartment_ocid
  domain          = var.oci_domain_name
  zone_name_or_id = data.oci_dns_zones.kasm_dns_zone.zones[0].name
  rtype           = "A"
  items {
    domain = var.oci_domain_name
    rdata  = oci_load_balancer.kasm_load_balancer.ip_address_details[0].ip_address
    rtype  = "A"
    ttl    = 300
  }
}
