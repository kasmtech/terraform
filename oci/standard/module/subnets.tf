## Will create WebApp subnets x.x.0.x/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "oci_core_subnet" "lb" {
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_vcn.this.id
  route_table_id  = oci_core_route_table.internet_gateway.id
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
  cidr_block      = cidrsubnet(var.vcn_subnet_cidr, local.kasm_server_subnet_cidr_size, 0)
  display_name    = "${var.project_name}-public-lb-subnet"
  dns_label       = "${var.project_name}lb"
  security_list_ids = [
    oci_core_security_list.allow_web.id,
    oci_core_security_list.allow_public_ssh.id
  ]
}

## Will create WebApp subnets x.x.1.x/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "oci_core_subnet" "webapp" {
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_vcn.this.id
  route_table_id  = oci_core_route_table.nat_gateway.id
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
  cidr_block      = cidrsubnet(var.vcn_subnet_cidr, local.kasm_server_subnet_cidr_size, 1)
  display_name    = "${var.project_name}-webapp-subnet"
  dns_label       = "${var.project_name}webapp"
  security_list_ids = [
    oci_core_security_list.allow_web_from_lb.id,
    oci_core_security_list.allow_bastion_ssh.id
  ]
}

## Will create Agent subnet x.x.2.x/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "oci_core_subnet" "db" {
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_vcn.this.id
  route_table_id  = oci_core_route_table.nat_gateway.id
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
  cidr_block      = cidrsubnet(var.vcn_subnet_cidr, local.kasm_server_subnet_cidr_size, 2)
  display_name    = "${var.project_name}-db-subnet"
  dns_label       = "${var.project_name}db"
  security_list_ids = [
    oci_core_security_list.allow_db_redis.id,
    oci_core_security_list.allow_bastion_ssh.id
  ]
}

## Will create Agent subnet x.x.3.x/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "oci_core_subnet" "agent" {
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_vcn.this.id
  route_table_id  = oci_core_route_table.internet_gateway.id
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
  cidr_block      = cidrsubnet(var.vcn_subnet_cidr, local.kasm_server_subnet_cidr_size, 3)
  display_name    = "${var.project_name}-agent-subnet"
  dns_label       = "${var.project_name}agent"
  security_list_ids = [
    oci_core_security_list.allow_web_from_webapp.id,
    oci_core_security_list.allow_bastion_ssh.id
  ]
}

## Will create Guac subnet x.x.4.x/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "oci_core_subnet" "cpx" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_vcn.this.id
  route_table_id  = oci_core_route_table.nat_gateway.id
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
  cidr_block      = cidrsubnet(var.vcn_subnet_cidr, local.kasm_server_subnet_cidr_size, 4)
  display_name    = "${var.project_name}-cpx-subnet"
  dns_label       = "${var.project_name}cpx"
  security_list_ids = [
    oci_core_security_list.allow_web_from_webapp.id,
    oci_core_security_list.allow_bastion_ssh.id
  ]
}

## Will create Guac subnet x.x.5.x/24 (assuming a VPC Subnet CIDR between x.x.0.0/16 and x.x.0.0/21)
resource "oci_core_subnet" "windows" {
  count = var.num_cpx_nodes > 0 ? 1 : 0

  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.this.id
  route_table_id    = oci_core_route_table.internet_gateway.id
  dhcp_options_id   = oci_core_vcn.this.default_dhcp_options_id
  cidr_block        = cidrsubnet(var.vcn_subnet_cidr, local.kasm_server_subnet_cidr_size, 5)
  display_name      = "${var.project_name}-windows-subnet"
  dns_label         = "${var.project_name}win"
  security_list_ids = oci_core_security_list.allow_rdp_to_windows[*].id
}
