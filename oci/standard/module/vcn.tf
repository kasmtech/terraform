resource "oci_core_vcn" "this" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "${var.project_name}-VCN"
  dns_label      = "${var.project_name}vcn"
}

resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.project_name}-Internet-Gateway"
  vcn_id         = oci_core_vcn.this.id
}

resource "oci_core_nat_gateway" "this" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.project_name}-NAT-Gateway"
  vcn_id         = oci_core_vcn.this.id
}

resource "oci_core_route_table" "internet_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "Kasm-IG-RouteTable"

  route_rules {
    destination       = var.anywhere[0]
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.this.id
  }
}

resource "oci_core_route_table" "nat_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "Kasm-NAT-RouteTable"

  route_rules {
    destination       = var.anywhere[0]
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.this.id
  }
}
