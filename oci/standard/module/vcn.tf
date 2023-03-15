resource "oci_core_vcn" "kasm_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "${var.project_name}-VCN"
  dns_label      = "${var.project_name}vcn"
}

data "oci_core_vcn" "data-kasm_vcn" {
  vcn_id = oci_core_vcn.kasm_vcn.id
}

resource "oci_core_internet_gateway" "kasm_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.project_name}-Gateway"
  vcn_id         = oci_core_vcn.kasm_vcn.id
}

data "oci_core_internet_gateways" "data-kasm_internet_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = data.oci_core_vcn.data-kasm_vcn.id
}

resource "oci_core_route_table" "default_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = data.oci_core_vcn.data-kasm_vcn.id
  display_name   = "KasmRouteTable"

  route_rules {
    destination       = var.anywhere[0]
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.kasm_internet_gateway.id #data.oci_core_internet_gateways.data-kasm_internet_gateway.gateways[0].id
  }
}

# data "oci_core_route_tables" "data-default_route_table" {
#   compartment_id = var.compartment_ocid
#   vcn_id         = data.oci_core_vcn.data-kasm_vcn.id
#   display_name   = oci_core_route_table.default_route_table.display_name
# }

data "oci_identity_availability_domains" "kasm_ads" {
  compartment_id = var.tenancy_ocid
}
