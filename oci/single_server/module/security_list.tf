
resource "oci_core_security_list" "allow_web" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.kasm_vcn.id
    display_name = "allow_web"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        stateless = "false"
    }

    ingress_security_rules {
        protocol = "6"
        source = "${var.allow_web_cidr}"
        tcp_options {
            max = "443"
            min = "443"
        }
    }
}

resource "oci_core_security_list" "allow_ssh" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.kasm_vcn.id
    display_name = "allow_ssh"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        stateless = "false"
    }

    ingress_security_rules {
        protocol = "6"
        source = "${var.allow_ssh_cidr}"
        tcp_options {
            max = "22"
            min = "22"
        }
    }
}
