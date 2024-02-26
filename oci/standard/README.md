# OCI Multi-Server
This project will deploy Kasm Workspaces in a multi-server deployment in OCI.


![Diagram][Image_Diagram]

[Image_Diagram]: https://f.hubspotusercontent30.net/hubfs/5856039/terraform/diagrams/oci-multi-server.png "Diagram"



# Pre-Configuration
Consider creating a new Compartment for the Kasm Workspaces deployment.

### DNS Zone
In OCI create a public DNS zone that matches the desired domain name for the deployment. e.g `kasm.contoso.com`.

### API Keys
Create an administative user in the OCI console that will be used for the terraform deployment. Add the user to the **Administrators** Group. Generate an API Key for the user. The API Key Fingerprint will be used as a variable in the deployment configuration. Save the private key to the local directory replacing `oci-private-key.pem`.

### SSL Certificate Options
#### Terraform-generated Let's Encrypt Certificate
To use Terraform to generate a Let's Encrypt certificate automatically, set the `letsencrypt_cert_support_email` to a valid email address and set the `letsencrypt_server_type` to either "staging" or "prod" and leave the `kasm_ssl_crt_path` and `kasm_ssl_key_path` variables empty.
***NOTE:***
- Staging generates certificates that a browser will not trust, but are formatted correctly and are designed for testing and validating the system configuraiton and deployment and has a limit of hundreds of certificates per domain per week.
- Prod generates valid Let's Encrypt certificates but is limited to 5 certificates per week per domain.

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

5. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`. It may take several minutes for the deployment to fully come online.

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
| <a name="input_bastion_vm_settings"></a> [bastion\_vm\_settings](#input\_bastion\_vm\_settings) | The number of CPUs, amount of memory in GB, and HDD size in GB to configure for the Kasm SSH Bastion instance | <pre>object({<br>    cpus        = number<br>    memory      = number<br>    hdd_size_gb = number<br>  })</pre> | n/a | yes |
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | The Compartment OCID | `string` | n/a | yes |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | The password for the database. No special characters | `string` | n/a | yes |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | API Key Fingerprint | `string` | n/a | yes |
| <a name="input_instance_image_ocid"></a> [instance\_image\_ocid](#input\_instance\_image\_ocid) | The OCID for the instance image, such as ubuntu 22.04, to use. | `string` | n/a | yes |
| <a name="input_instance_shape"></a> [instance\_shape](#input\_instance\_shape) | The instance shape to use. Should be a Flex type. | `string` | n/a | yes |
| <a name="input_kasm_agent_vm_settings"></a> [kasm\_agent\_vm\_settings](#input\_kasm\_agent\_vm\_settings) | The number of CPUs, amount of memory in GB, and HDD size in GB to configure for the Kasm Agent instances | <pre>object({<br>    cpus        = number<br>    memory      = number<br>    hdd_size_gb = number<br>  })</pre> | n/a | yes |
| <a name="input_kasm_build_url"></a> [kasm\_build\_url](#input\_kasm\_build\_url) | The URL for the Kasm Workspaces build | `string` | n/a | yes |
| <a name="input_kasm_cpx_vm_settings"></a> [kasm\_cpx\_vm\_settings](#input\_kasm\_cpx\_vm\_settings) | The number of CPUs, amount of memory in GB, and HDD size in GB to configure for the Kasm cpx RDP instances | <pre>object({<br>    cpus        = number<br>    memory      = number<br>    hdd_size_gb = number<br>  })</pre> | n/a | yes |
| <a name="input_kasm_database_vm_settings"></a> [kasm\_database\_vm\_settings](#input\_kasm\_database\_vm\_settings) | The number of CPUs, amount of memory in GB, and HDD size in GB to configure for the Kasm Database instance | <pre>object({<br>    cpus        = number<br>    memory      = number<br>    hdd_size_gb = number<br>  })</pre> | n/a | yes |
| <a name="input_kasm_ssl_crt_path"></a> [kasm\_ssl\_crt\_path](#input\_kasm\_ssl\_crt\_path) | The file path to the PEM encoded SSL Certificate | `string` | `""` | no |
| <a name="input_kasm_ssl_key_path"></a> [kasm\_ssl\_key\_path](#input\_kasm\_ssl\_key\_path) | The file path to the PEM encoded SSL Certificate Key | `string` | `""` | no |
| <a name="input_kasm_webapp_vm_settings"></a> [kasm\_webapp\_vm\_settings](#input\_kasm\_webapp\_vm\_settings) | The number of CPUs, amount of memory in GB, and HDD size in GB to configure for the Kasm WebApp instances | <pre>object({<br>    cpus        = number<br>    memory      = number<br>    hdd_size_gb = number<br>  })</pre> | n/a | yes |
| <a name="input_letsencrypt_cert_support_email"></a> [letsencrypt\_cert\_support\_email](#input\_letsencrypt\_cert\_support\_email) | Email address to use for Let's Encrypt SSL certificates for OCI Deployment | `string` | `""` | no |
| <a name="input_letsencrypt_server_type"></a> [letsencrypt\_server\_type](#input\_letsencrypt\_server\_type) | SSL Server type to generate. Valid options are staging and prod, and prod certificates are limited to 5 certificates per week. | `string` | `""` | no |
| <a name="input_manager_token"></a> [manager\_token](#input\_manager\_token) | The manager token value for Agents to authenticate to webapps. No special characters | `string` | n/a | yes |
| <a name="input_num_agents"></a> [num\_agents](#input\_num\_agents) | The number of Agent Role Servers to create in the deployment | `number` | n/a | yes |
| <a name="input_num_cpx_nodes"></a> [num\_cpx\_nodes](#input\_num\_cpx\_nodes) | The number of cpx RDP Role Servers to create in the deployment | `number` | n/a | yes |
| <a name="input_num_webapps"></a> [num\_webapps](#input\_num\_webapps) | The number of WebApp role servers to create in the deployment | `number` | n/a | yes |
| <a name="input_oci_domain_name"></a> [oci\_domain\_name](#input\_oci\_domain\_name) | The public Zone used for the dns entries. This must already exist in the OCI account. (e.g kasm.contoso.com). The deployment will be accessed via this zone name via https | `string` | n/a | yes |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | The path to the API Key PEM encoded Private Key | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the deployment (e.g dev, staging). A short single word | `string` | n/a | yes |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | The password for the Redis server. No special characters | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI Region eg: (us-ashburn-1) | `string` | n/a | yes |
| <a name="input_service_registration_token"></a> [service\_registration\_token](#input\_service\_registration\_token) | The service registration token value for cpx RDP servers to authenticate to webapps. No special characters | `string` | n/a | yes |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | The SSH Public Keys to be installed on the OCI compute instance | `string` | n/a | yes |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The amount of swap (in MB) to configure inside the compute instances | `number` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The Tenancy OCID. | `string` | n/a | yes |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | The User OCID. | `string` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | The standard (non administrator) user password. No special characters | `string` | n/a | yes |
| <a name="input_vcn_subnet_cidr"></a> [vcn\_subnet\_cidr](#input\_vcn\_subnet\_cidr) | VCN Subnet CIDR where you wish to deploy Kasm | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Detailed Terraform Deployment Diagram

![Detailed Diagram][Detailed_Diagram]

[Detailed_Diagram]: ./diagram/oci_multi_server.png "Detailed Diagram"
