
resource "oci_core_vcn" "kasm_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "${var.project_name}-VCN"
  dns_label      = "${var.project_name}vcn"
}


resource "oci_core_internet_gateway" "kasm_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.project_name}-Gateway"
  vcn_id         = oci_core_vcn.kasm_vcn.id
}

resource "oci_core_default_route_table" "default_route_table" {
  manage_default_resource_id = oci_core_vcn.kasm_vcn.default_route_table_id
  display_name               = "DefaultRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.kasm_internet_gateway.id
  }
}

resource "oci_core_subnet" "kasm_subnet" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.0.10.0/24"
  display_name        = "${var.project_name}-Subnet"
  dns_label           = "${var.project_name}subnet"
  security_list_ids   = [oci_core_security_list.allow_web.id, oci_core_security_list.allow_ssh.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.kasm_vcn.id
  route_table_id      = oci_core_vcn.kasm_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.kasm_vcn.default_dhcp_options_id
}


data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}
