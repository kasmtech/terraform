resource "oci_dns_rrset" "kasm_a_record" {
    domain = var.oci_domain_name
    rtype = "A"
    zone_name_or_id = var.oci_domain_name
    compartment_id = var.compartment_ocid
     items {
          domain = var.oci_domain_name
          rdata = oci_load_balancer_load_balancer.kasm_load_balancer.ip_addresses[0]
          rtype = "A"
          ttl = 300
      }
}