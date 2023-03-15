locals {
  kasm_vcn_subnet_cidr_mask           = split("/", var.vcn_subnet_cidr)[1]
  kasm_server_subnet_cidr_calculation = (8 - (local.kasm_vcn_subnet_cidr_mask - 16))
  kasm_server_subnet_cidr_size        = local.kasm_server_subnet_cidr_calculation < 3 ? 3 : local.kasm_server_subnet_cidr_calculation
  kasm_agent_subnet_id                = (var.num_webapps + 1)
}

## Will create Agent subnet x.x.0.x/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "oci_core_subnet" "kasm-db-subnet" {
  compartment_id      = var.compartment_ocid
  vcn_id              = data.oci_core_vcn.data-kasm_vcn.id
  route_table_id      = oci_core_route_table.default_route_table.id
  dhcp_options_id     = data.oci_core_vcn.data-kasm_vcn.default_dhcp_options_id
  availability_domain = data.oci_identity_availability_domains.kasm_ads.availability_domains[0].name
  cidr_block          = cidrsubnet(var.vcn_subnet_cidr, local.kasm_server_subnet_cidr_size, 0)
  display_name        = "${var.project_name}-db-subnet"
  dns_label           = "${var.project_name}db"
  security_list_ids = [
    data.oci_core_security_lists.data-allow_db_redis.security_lists[0].id,
    data.oci_core_security_lists.data-allow_ssh.security_lists[0].id
  ]
}

data "oci_core_subnet" "data-kasm_db_subnet" {
  subnet_id = oci_core_subnet.kasm-db-subnet.id
}

## Will create WebApp subnets x.x.1.x/24 and x.x.2.x/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21, and 2 WebApps)
resource "oci_core_subnet" "kasm-webapp-subnets" {
  count               = var.num_webapps
  compartment_id      = var.compartment_ocid
  vcn_id              = data.oci_core_vcn.data-kasm_vcn.id
  route_table_id      = oci_core_route_table.default_route_table.id
  dhcp_options_id     = data.oci_core_vcn.data-kasm_vcn.default_dhcp_options_id
  availability_domain = data.oci_identity_availability_domains.kasm_ads.availability_domains[count.index].name
  cidr_block          = cidrsubnet(var.vcn_subnet_cidr, local.kasm_server_subnet_cidr_size, (count.index + 1))
  display_name        = "${var.project_name}-webapp-subnet${count.index}"
  dns_label           = "${var.project_name}webapp${count.index}"
  security_list_ids = [
    data.oci_core_security_lists.data-allow_web.security_lists[0].id,
    data.oci_core_security_lists.data-allow_ssh.security_lists[0].id
  ]
}

data "oci_core_subnets" "data-kasm_webapp_subnets" {
  count          = var.num_webapps
  compartment_id = var.compartment_ocid
  vcn_id         = data.oci_core_vcn.data-kasm_vcn.id
  display_name   = oci_core_subnet.kasm-webapp-subnets[count.index].display_name
}

## Will create Agent subnet x.x.3.x/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "oci_core_subnet" "kasm-agent-subnet" {
  compartment_id      = var.compartment_ocid
  vcn_id              = data.oci_core_vcn.data-kasm_vcn.id
  route_table_id      = oci_core_route_table.default_route_table.id
  dhcp_options_id     = data.oci_core_vcn.data-kasm_vcn.default_dhcp_options_id
  availability_domain = data.oci_identity_availability_domains.kasm_ads.availability_domains[0].name
  cidr_block          = cidrsubnet(var.vcn_subnet_cidr, local.kasm_server_subnet_cidr_size, local.kasm_agent_subnet_id)
  display_name        = "${var.project_name}-agent-subnet"
  dns_label           = "${var.project_name}agent"
  security_list_ids = [
    data.oci_core_security_lists.data-allow_web_from_webapp.security_lists[0].id,
    data.oci_core_security_lists.data-allow_ssh.security_lists[0].id
  ]
}

data "oci_core_subnet" "data-kasm_agent_subnet" {
  subnet_id = oci_core_subnet.kasm-agent-subnet.id
}

## Will create Guac subnet x.x.4.x/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "oci_core_subnet" "kasm-guac-subnet" {
  compartment_id      = var.compartment_ocid
  vcn_id              = data.oci_core_vcn.data-kasm_vcn.id
  route_table_id      = oci_core_route_table.default_route_table.id
  dhcp_options_id     = data.oci_core_vcn.data-kasm_vcn.default_dhcp_options_id
  availability_domain = data.oci_identity_availability_domains.kasm_ads.availability_domains[0].name
  cidr_block          = cidrsubnet(var.vcn_subnet_cidr, local.kasm_server_subnet_cidr_size, (local.kasm_agent_subnet_id + 1))
  display_name        = "${var.project_name}-guac-subnet"
  dns_label           = "${var.project_name}guac"
  security_list_ids = [
    data.oci_core_security_lists.data-allow_web_from_webapp.security_lists[0].id,
    data.oci_core_security_lists.data-allow_ssh.security_lists[0].id
  ]
}

data "oci_core_subnet" "data-kasm_guac_subnet" {
  subnet_id = oci_core_subnet.kasm-guac-subnet.id
}
