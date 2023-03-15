resource "oci_core_security_list" "allow_web" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.kasm_vcn.id
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

data "oci_core_security_lists" "data-allow_web" {
  compartment_id = var.compartment_ocid
  display_name   = oci_core_security_list.allow_web.display_name
}

resource "oci_core_security_list" "allow_ssh" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.kasm_vcn.id
  display_name   = "allow_ssh"

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

data "oci_core_security_lists" "data-allow_ssh" {
  compartment_id = var.compartment_ocid
  display_name   = oci_core_security_list.allow_ssh.display_name
}

resource "oci_core_security_list" "allow_db_redis" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.kasm_vcn.id
  display_name   = "allow_db_redis"

  dynamic "egress_security_rules" {
    for_each = var.anywhere

    content {
      destination = egress_security_rules.value
      protocol    = "all"
      stateless   = "false"
    }
  }

  dynamic "ingress_security_rules" {
    for_each = [for cidr_block in data.oci_core_subnets.data-kasm_webapp_subnets : cidr_block.subnets[0].cidr_block]
    content {
      protocol = "6"
      source   = ingress_security_rules.value
      tcp_options {
        max = "5432"
        min = "5432"
      }
    }
  }

  dynamic "ingress_security_rules" {
    for_each = [for cidr_block in data.oci_core_subnets.data-kasm_webapp_subnets : cidr_block.subnets[0].cidr_block]
    content {
      protocol = "6"
      source   = ingress_security_rules.value
      tcp_options {
        max = "6379"
        min = "6379"
      }
    }
  }
}

data "oci_core_security_lists" "data-allow_db_redis" {
  compartment_id = var.compartment_ocid
  display_name   = oci_core_security_list.allow_db_redis.display_name
}

resource "oci_core_security_list" "allow_web_from_webapp" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.kasm_vcn.id
  display_name   = "allow_web_from_webapp"

  dynamic "egress_security_rules" {
    for_each = var.anywhere

    content {
      destination = egress_security_rules.value
      protocol    = "all"
      stateless   = "false"
    }
  }

  dynamic "ingress_security_rules" {
    for_each = [for cidr_block in data.oci_core_subnets.data-kasm_webapp_subnets : cidr_block.subnets[0].cidr_block]
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

data "oci_core_security_lists" "data-allow_web_from_webapp" {
  compartment_id = var.compartment_ocid
  display_name   = oci_core_security_list.allow_web_from_webapp.display_name
}
