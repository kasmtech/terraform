
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



data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

data "oci_identity_availability_domain" "ad2" {
  compartment_id = var.tenancy_ocid
  ad_number      = 2
}
