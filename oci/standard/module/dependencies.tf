locals {
  kasm_vcn_subnet_cidr_mask           = split("/", var.vcn_subnet_cidr)[1]
  kasm_server_subnet_cidr_calculation = (8 - (local.kasm_vcn_subnet_cidr_mask - 16))
  kasm_server_subnet_cidr_size        = local.kasm_server_subnet_cidr_calculation < 3 ? 3 : local.kasm_server_subnet_cidr_calculation

  availability_domains = data.oci_identity_availability_domains.kasm_ads.availability_domains
}

data "oci_dns_zones" "this" {
  compartment_id = var.compartment_ocid
  name           = var.oci_domain_name
}

data "oci_identity_availability_domains" "kasm_ads" {
  compartment_id = var.compartment_ocid
}
