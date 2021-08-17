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
        source = var.allow_web_cidr
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
        source = var.allow_ssh_cidr
        tcp_options {
            max = "22"
            min = "22"
        }
    }
}


resource "oci_core_security_list" "allow_db_redis" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.kasm_vcn.id
    display_name = "allow_db_redis"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        stateless = "false"
    }

    ingress_security_rules {
        protocol = "6"
        source = oci_core_subnet.kasm-webapp-subnet.cidr_block
        tcp_options {
            max = "5432"
            min = "5432"
        }
    }
   ingress_security_rules {
        protocol = "6"
        source = oci_core_subnet.kasm-webapp-subnet.cidr_block
        tcp_options {
            max = "6379"
            min = "6379"
        }
    }
}


resource "oci_core_security_list" "allow_web_from_webapp" {
    compartment_id = var.compartment_ocid
    vcn_id = oci_core_vcn.kasm_vcn.id
    display_name = "allow_web_from_webapp"

    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
        stateless = "false"
    }

    ingress_security_rules {
        protocol = "6"
        source = var.webapp_cidr_1
        tcp_options {
            max = "443"
            min = "443"
        }
    }
    ingress_security_rules {
        protocol = "6"
        source = var.webapp_cidr_2
        tcp_options {
            max = "443"
            min = "443"
        }
    }
}
