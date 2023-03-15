resource "oci_core_security_list" "allow_web" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.kasm_vcn.id
  display_name   = "allow_web"

  egress_security_rules {
    destination = var.anywhere
    protocol    = "all"
    stateless   = "false"
  }

  dynamic "ingress_security_rules" {
    for_each = var.allow_web_cidrs
    content {
      protocol = "6"
      source   = ingress_security_rules.value
      tcp_options {
        max = "443"
        min = "443"
      }
    }
  }
}

resource "oci_core_security_list" "allow_ssh" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.kasm_vcn.id
  display_name   = "allow_ssh"

  egress_security_rules {
    destination = var.anywhere
    protocol    = "all"
    stateless   = "false"
  }

  dynamic "ingress_security_rules" {
    for_each = var.allow_ssh_cidrs
    content {
      protocol = "6"
      source   = ingress_security_rules.value
      tcp_options {
        max = "22"
        min = "22"
      }
    }
  }
}
