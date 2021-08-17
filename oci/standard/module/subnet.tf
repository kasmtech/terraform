resource "oci_core_subnet" "kasm-db-subnet" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.0.10.0/24"
  display_name        = "${var.project_name}-kasm-db-subnet"
  dns_label           = "${var.project_name}db"
  security_list_ids   = [oci_core_security_list.allow_db_redis.id, oci_core_security_list.allow_ssh.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.kasm_vcn.id
  route_table_id      = oci_core_vcn.kasm_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.kasm_vcn.default_dhcp_options_id
}

resource "oci_core_subnet" "kasm-webapp-subnet" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = var.webapp_cidr_1
  display_name        = "${var.project_name}-kasm-webapp-subnet"
  dns_label           = "${var.project_name}webapp"
  security_list_ids   = [oci_core_security_list.allow_web.id, oci_core_security_list.allow_ssh.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.kasm_vcn.id
  route_table_id      = oci_core_vcn.kasm_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.kasm_vcn.default_dhcp_options_id
}

resource "oci_core_subnet" "kasm-webapp-subnet-2" {
  availability_domain = data.oci_identity_availability_domain.ad2.name
  cidr_block          = var.webapp_cidr_2
  display_name        = "${var.project_name}-kasm-webapp-subnet-2"
  dns_label           = "${var.project_name}webapp2"
  security_list_ids   = [oci_core_security_list.allow_web.id, oci_core_security_list.allow_ssh.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.kasm_vcn.id
  route_table_id      = oci_core_vcn.kasm_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.kasm_vcn.default_dhcp_options_id
}


resource "oci_core_subnet" "kasm-agent-subnet" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.0.30.0/24"
  display_name        = "${var.project_name}-kasm-agent-subnet"
  dns_label           = "${var.project_name}agent"
  security_list_ids   = [oci_core_security_list.allow_web_from_webapp.id, oci_core_security_list.allow_ssh.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.kasm_vcn.id
  route_table_id      = oci_core_vcn.kasm_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.kasm_vcn.default_dhcp_options_id
}