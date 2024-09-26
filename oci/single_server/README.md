# OCI Single Server
This project will deploy Kasm Workspaces in a single-server deployment in OCI.


![Diagram][Image_Diagram]

[Image_Diagram]: https://f.hubspotusercontent30.net/hubfs/5856039/terraform/diagrams/oci-single-server.png "Diagram"



# Pre-Configuration

Consider creating a new Compartment for the Kasm Workspaces deployment.

### DNS Zone

In OCI create a public DNS zone that matches the desired domain name for the deployment. e.g `kasm.contoso.com`.

### API Keys

Create an administative user in the OCI console that will be used for the terraform deployment. Add the user to the **Administrators** Group. Generate an API Key for the user. The API Key Fingerprint will be used as a variable in the deployment configuration. Save the private key to the local directory replacing `oci-private-key.pem`.

### SSL Certificate Options

#### Terraform-generated Let's Encrypt Certificate

To use Terraform to generate a Let's Encrypt certificate automatically, set the `letsencrypt_cert_support_email` to a valid email address and set the `letsencrypt_server_type` to either "staging" or "prod" and leave the `kasm_ssl_crt_path` and `kasm_ssl_key_path` variables empty.

> ***NOTE:***
> - Staging generates certificates that a browser will not trust, but are formatted correctly and are designed for testing and validating the system configuraiton and deployment and has a limit of hundreds of certificates per domain per week.
> - Prod generates trusted Let's Encrypt certificates but is limited to 5 certificates per week per domain.

#### Bring Your Own Certificates

Create an SSL certificate that matches the desired domain for the deployment. e.g (kasm.contoso.com). Place the pem encoded cert and key in this directory overwriting  `kasm_ssl.crt` and `kasm_ssl.key`.


# Terraform Configuration

1. Initialize the project

       terraform init

2. Open `settings.tfvars` and update the variables. The variable definitions, descriptions, and validation requirements can be found in `variables.tf`, or in the [table](#oci-terraform-variable-definitions) below.

3. Verify the configuration

       terraform plan

4. Deploy

       terraform apply

5. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`. Single server installs download all workspaces images during the install process so it may take ~15 minutes for the server to fully come online.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_acme"></a> [acme](#requirement\_acme) | ~> 2.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | ~> 5.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kasm"></a> [kasm](#module\_kasm) | ./module | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The administrative user password. No special characters | `string` | n/a | yes |
| <a name="input_allow_ssh_cidrs"></a> [allow\_ssh\_cidrs](#input\_allow\_ssh\_cidrs) | The CIDR notation to allow SSH access to the systems. | `list(string)` | n/a | yes |
| <a name="input_allow_web_cidrs"></a> [allow\_web\_cidrs](#input\_allow\_web\_cidrs) | The CIDR notation to allow HTTPS access to the systems. | `list(string)` | n/a | yes |
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | The Compartment OCID | `string` | n/a | yes |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | API Key Fingerprint | `string` | n/a | yes |
| <a name="input_instance_image_ocid"></a> [instance\_image\_ocid](#input\_instance\_image\_ocid) | The OCID for the instance image , such as ubuntu 20.04, to use. | `string` | n/a | yes |
| <a name="input_instance_shape"></a> [instance\_shape](#input\_instance\_shape) | The instance shape to use. Should be a Flex type. | `string` | n/a | yes |
| <a name="input_kasm_build_url"></a> [kasm\_build\_url](#input\_kasm\_build\_url) | The URL for the Kasm Workspaces build | `string` | n/a | yes |
| <a name="input_kasm_server_cpus"></a> [kasm\_server\_cpus](#input\_kasm\_server\_cpus) | The number of CPUs to configure for the Kasm instance | `number` | n/a | yes |
| <a name="input_kasm_server_hdd_size"></a> [kasm\_server\_hdd\_size](#input\_kasm\_server\_hdd\_size) | The size in GBs of the Kasm instance HDD | `number` | n/a | yes |
| <a name="input_kasm_server_memory"></a> [kasm\_server\_memory](#input\_kasm\_server\_memory) | The amount of memory to configure for the Kasm instance | `number` | n/a | yes |
| <a name="input_kasm_ssl_crt_path"></a> [kasm\_ssl\_crt\_path](#input\_kasm\_ssl\_crt\_path) | The file path to the PEM encoded SSL Certificate. Leave this empty if you are using Lets Encrypt to automatically generate your certificates. | `string` | `""` | no |
| <a name="input_kasm_ssl_key_path"></a> [kasm\_ssl\_key\_path](#input\_kasm\_ssl\_key\_path) | The file path to the PEM encoded SSL Certificate Key. Leave this empty if you are using Lets Encrypt to automatically generate your certificates. | `string` | `""` | no |
| <a name="input_letsencrypt_cert_support_email"></a> [letsencrypt\_cert\_support\_email](#input\_letsencrypt\_cert\_support\_email) | Email address to use for Let's Encrypt SSL certificates for OCI Deployment | `string` | `""` | no |
| <a name="input_letsencrypt_server_type"></a> [letsencrypt\_server\_type](#input\_letsencrypt\_server\_type) | SSL Server type to generate. Valid options are staging and prod, and prod certificates are limited to 5 certificates per week. | `string` | `""` | no |
| <a name="input_oci_domain_name"></a> [oci\_domain\_name](#input\_oci\_domain\_name) | The public Zone used for the dns entries. This must already exist in the OCI account. (e.g kasm.contoso.com). The deployment will be accessed via this zone name via https | `string` | n/a | yes |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | The path to the OCI API Key PEM encoded Private Key | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the deployment (e.g dev, staging). A short single word | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI Region eg: (us-ashburn-1) | `string` | n/a | yes |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | The SSH Public Keys to be installed on the OCI compute instance | `string` | n/a | yes |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The amount of swap (in GB) to configure inside the compute instances | `number` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The Tenancy OCID. | `string` | n/a | yes |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | The User OCID. | `string` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | The standard (non administrator) user password. No special characters | `string` | n/a | yes |
| <a name="input_vcn_subnet_cidr"></a> [vcn\_subnet\_cidr](#input\_vcn\_subnet\_cidr) | VCN Subnet CIDR where you wish to deploy Kasm | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ssh_key_info"></a> [ssh\_key\_info](#output\_ssh\_key\_info) | SSH Keys to use with Kasm Deployment |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Detailed Terraform Deployment Diagram

![Detailed Diagram][Detailed_Diagram]

[Detailed_Diagram]: ./diagram/oci_single_server.png "Detailed Diagram"
