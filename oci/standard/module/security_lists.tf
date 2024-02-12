resource "oci_core_security_list" "allow_web" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "allow_web"

  dynamic "egress_security_rules" {
    for_each = var.anywhere

    content {
      destination = egress_security_rules.value
      protocol    = "all"
      stateless   = "false"
    }
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

resource "oci_core_security_list" "allow_public_ssh" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "allow_public_ssh"

  dynamic "egress_security_rules" {
    for_each = var.anywhere

    content {
      destination = egress_security_rules.value
      protocol    = "all"
      stateless   = "false"
    }
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

resource "oci_core_security_list" "allow_bastion_ssh" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "allow_bastion_ssh"

  ingress_security_rules {
    protocol = "6"
    source   = "${oci_core_instance.bastion.private_ip}/32"
    tcp_options {
      max = "22"
      min = "22"
    }
  }
}

resource "oci_core_security_list" "allow_db_redis" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "allow_db_redis"

  dynamic "egress_security_rules" {
    for_each = var.anywhere

    content {
      destination = egress_security_rules.value
      protocol    = "all"
      stateless   = "false"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = oci_core_subnet.webapp.cidr_block
    tcp_options {
      max = "5432"
      min = "5432"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = oci_core_subnet.webapp.cidr_block
    tcp_options {
      max = "6379"
      min = "6379"
    }
  }
}

resource "oci_core_security_list" "allow_web_from_lb" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "allow_web_from_webapp"

  dynamic "egress_security_rules" {
    for_each = var.anywhere

    content {
      destination = egress_security_rules.value
      protocol    = "all"
      stateless   = "false"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = oci_core_subnet.lb.cidr_block
    tcp_options {
      max = "443"
      min = "443"
    }
  }
}

resource "oci_core_security_list" "allow_web_from_webapp" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "allow_web_from_webapp"

  dynamic "egress_security_rules" {
    for_each = var.anywhere

    content {
      destination = egress_security_rules.value
      protocol    = "all"
      stateless   = "false"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = oci_core_subnet.webapp.cidr_block
    tcp_options {
      max = "443"
      min = "443"
    }
  }
}

resource "oci_core_security_list" "allow_rdp_to_windows" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "allow_rdp_for_windows"

  dynamic "egress_security_rules" {
    for_each = var.anywhere

    content {
      destination = egress_security_rules.value
      protocol    = "all"
      stateless   = "false"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = oci_core_subnet.webapp.cidr_block
    tcp_options {
      max = "4902"
      min = "4902"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = one(oci_core_subnet.cpx[*].cidr_block)
    tcp_options {
      max = "3389"
      min = "3389"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = one(oci_core_subnet.cpx[*].cidr_block)
    tcp_options {
      max = "4902"
      min = "4902"
    }
  }
}
