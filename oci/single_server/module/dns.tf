resource "oci_dns_rrset" "kasm_a_record" {
    domain = var.oci_domain_name
    rtype = "A"
    zone_name_or_id = var.oci_domain_name
    compartment_id = var.compartment_ocid
     items {
          domain = var.oci_domain_name
          rdata = oci_core_instance.kasm_instance.public_ip
          rtype = "A"
          ttl = 300
      }
}