# DigitalOcean Single Server

This project will deploy Kasm Workspaces in a single-server deployment on DigitalOcean.

![Diagram][Image_Diagram]

[Image_Diagram]: https://f.hubspotusercontent30.net/hubfs/5856039/terraform/diagrams/digitalocean-single-server.png "Diagram"

# Pre-Configuration

### Domain Configuration

If digitalocean is not already managing your domain you will need to have your registrar point to the DigitalOcean nameservers: https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars

### API Tokens

Create a personal access token with read/write permissions at https://cloud.digitalocean.com/account/api/tokens

### SSH Authorized Keys

This project will launch a droplet and allow connections using the ssh keys defined by `ssh_key_fingerprints`. You can copy the fingerprint from the desired ssh keys from https://cloud.digitalocean.com/account/security

# Terraform Configuration

1. Initialize the project

       terraform init

2. Open `settings.tf` and update the variables. The variable definitions and descriptions can be found in `variables.tf`.

> ***NOTE:*** This document assumes you are using a separate file named `secrets.tfvars` for the DigitalOcean token credential. The .gitignore file in this repository will ignore any files named `secrets.tfvars` since they are expected to have sensitive values in them. This will prevent you from accidentally committing them to source control. Refer to the [Generating a DigitalOcean Access Token](https://docs.digitalocean.com/reference/api/create-personal-access-token/) document if you need help with this process.

3. Verify the configuration

       terraform plan -var-file secrets.tfvars

4. Deploy

       terraform apply -var-file secrets.tfvars


5. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`. Single server installs download all workspaces images during the install process so it may take ~15 minutes for the server to fully come online.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

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
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The default password to be used for the default admin@kasm.local account. Only use alphanumeric characters | `string` | `"changeme"` | no |
| <a name="input_allow_kasm_web_cidrs"></a> [allow\_kasm\_web\_cidrs](#input\_allow\_kasm\_web\_cidrs) | CIDR notation of the bastion host allowed to SSH in to the machines | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_allow_ssh_cidrs"></a> [allow\_ssh\_cidrs](#input\_allow\_ssh\_cidrs) | CIDR notation of the bastion host allowed to SSH in to the machines | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_digital_ocean_droplet_slug"></a> [digital\_ocean\_droplet\_slug](#input\_digital\_ocean\_droplet\_slug) | The Default Digital Ocean Droplet Slug: https://slugs.do-api.dev/ | `string` | `"s-2vcpu-4gb-intel"` | no |
| <a name="input_digital_ocean_image"></a> [digital\_ocean\_image](#input\_digital\_ocean\_image) | Default Image for Ubuntu 20.04 LTS with Docker | `string` | `"docker-20-04"` | no |
| <a name="input_digital_ocean_region"></a> [digital\_ocean\_region](#input\_digital\_ocean\_region) | The Digital Ocean region where you wish to deploy Kasm | `string` | `"nyc3"` | no |
| <a name="input_digital_ocean_token"></a> [digital\_ocean\_token](#input\_digital\_ocean\_token) | Authentication Token For Digital Ocean | `string` | n/a | yes |
| <a name="input_do_domain_name"></a> [do\_domain\_name](#input\_do\_domain\_name) | The domain name that users will use to access Kasm | `string` | n/a | yes |
| <a name="input_kasm_build_url"></a> [kasm\_build\_url](#input\_kasm\_build\_url) | The Kasm build file to install | `string` | `"https://kasm-static-content.s3.amazonaws.com/kasm_release_1.12.0.d4fd8a.tar.gz"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project/deployment/company eg (acme). | `string` | n/a | yes |
| <a name="input_ssh_key_fingerprints"></a> [ssh\_key\_fingerprints](#input\_ssh\_key\_fingerprints) | Keys used for sshing into kasm hosts | `list(string)` | n/a | yes |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The amount of swap (in GB) to configure inside the compute instances | `number` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | The default password to be used for the default user@kasm.local account. Only use alphanumeric characters | `string` | `"changeme"` | no |
| <a name="input_vpc_subnet_cidr"></a> [vpc\_subnet\_cidr](#input\_vpc\_subnet\_cidr) | VPC Subnet CIDR where you wish to deploy Kasm | `string` | `"10.0.0.0/24"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
