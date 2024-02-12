# module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_acme"></a> [acme](#requirement\_acme) | ~> 2.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | ~> 5.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_acme"></a> [acme](#provider\_acme) | 2.20.0 |
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.28.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [acme_certificate.certificate](https://registry.terraform.io/providers/vancluever/acme/latest/docs/resources/certificate) | resource |
| [acme_registration.registration](https://registry.terraform.io/providers/vancluever/acme/latest/docs/resources/registration) | resource |
| [oci_core_default_route_table.default_route_table](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_default_route_table) | resource |
| [oci_core_instance.kasm_instance](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance) | resource |
| [oci_core_internet_gateway.kasm_internet_gateway](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_internet_gateway) | resource |
| [oci_core_security_list.allow_ssh](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list) | resource |
| [oci_core_security_list.allow_web](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list) | resource |
| [oci_core_subnet.kasm_subnet](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet) | resource |
| [oci_core_vcn.kasm_vcn](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn) | resource |
| [oci_dns_rrset.kasm_a_record](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_rrset) | resource |
| [tls_cert_request.kasm_certificate_request](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_private_key.certificate_private_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.registration_private_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [oci_dns_zones.kasm_dns_zone](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/dns_zones) | data source |
| [oci_identity_availability_domain.ad](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domain) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The administrative user password. No special characters | `string` | n/a | yes |
| <a name="input_allow_ssh_cidrs"></a> [allow\_ssh\_cidrs](#input\_allow\_ssh\_cidrs) | The CIDR notation to allow SSH access to the systems. | `list(string)` | n/a | yes |
| <a name="input_allow_web_cidrs"></a> [allow\_web\_cidrs](#input\_allow\_web\_cidrs) | The CIDR notation to allow HTTPS access to the systems. | `list(string)` | n/a | yes |
| <a name="input_anywhere"></a> [anywhere](#input\_anywhere) | Anywhere route subnet | `string` | `"0.0.0.0/0"` | no |
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | The Compartment OCID | `string` | n/a | yes |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | API Key Fingerprint | `string` | n/a | yes |
| <a name="input_instance_image_ocid"></a> [instance\_image\_ocid](#input\_instance\_image\_ocid) | The OCID for the instance image , such as ubuntu 20.04, to use. | `string` | n/a | yes |
| <a name="input_instance_shape"></a> [instance\_shape](#input\_instance\_shape) | The instance shape to use. Should be a Flex type. | `string` | n/a | yes |
| <a name="input_kasm_build_url"></a> [kasm\_build\_url](#input\_kasm\_build\_url) | The URL for the Kasm Workspaces build | `string` | n/a | yes |
| <a name="input_kasm_server_cpus"></a> [kasm\_server\_cpus](#input\_kasm\_server\_cpus) | The number of CPUs to configure for the Kasm instance | `number` | n/a | yes |
| <a name="input_kasm_server_hdd_size"></a> [kasm\_server\_hdd\_size](#input\_kasm\_server\_hdd\_size) | The size in GBs of the Kasm instance HDD | `number` | n/a | yes |
| <a name="input_kasm_server_memory"></a> [kasm\_server\_memory](#input\_kasm\_server\_memory) | The amount of memory to configure for the Kasm instance | `number` | n/a | yes |
| <a name="input_kasm_ssl_crt_path"></a> [kasm\_ssl\_crt\_path](#input\_kasm\_ssl\_crt\_path) | The file path to the PEM encoded SSL Certificate | `string` | n/a | yes |
| <a name="input_kasm_ssl_key_path"></a> [kasm\_ssl\_key\_path](#input\_kasm\_ssl\_key\_path) | The file path to the PEM encoded SSL Certificate Key | `string` | n/a | yes |
| <a name="input_letsencrypt_cert_support_email"></a> [letsencrypt\_cert\_support\_email](#input\_letsencrypt\_cert\_support\_email) | Email address to use for Let's Encrypt SSL certificates for OCI Deployment | `string` | n/a | yes |
| <a name="input_letsencrypt_server_type"></a> [letsencrypt\_server\_type](#input\_letsencrypt\_server\_type) | SSL Server type to generate. Valid options are staging, prod, and empty string. Prod certificates are limited to 5 per week per domain. | `string` | n/a | yes |
| <a name="input_oci_domain_name"></a> [oci\_domain\_name](#input\_oci\_domain\_name) | The public Zone used for the dns entries. This must already exist in the OCI account. (e.g kasm.contoso.com). The deployment will be accessed via this zone name via https | `string` | n/a | yes |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | The path to the API Key PEM encoded Private Key | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the deployment (e.g dev, staging). A short single word | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI Region eg: (us-ashburn-1) | `string` | n/a | yes |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | The SSH Public Keys to be installed on the OCI compute instance | `string` | n/a | yes |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The amount of swap (in MB) to configure inside the compute instances | `number` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The Tenancy OCID. | `string` | n/a | yes |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | The User OCID. | `string` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | The standard (non administrator) user password. No special characters | `string` | n/a | yes |
| <a name="input_vcn_subnet_cidr"></a> [vcn\_subnet\_cidr](#input\_vcn\_subnet\_cidr) | VPC Subnet CIDR where you wish to deploy Kasm | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
