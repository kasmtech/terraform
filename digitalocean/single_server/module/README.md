# module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.34.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_certificate.cert](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/certificate) | resource |
| [digitalocean_domain.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/domain) | resource |
| [digitalocean_droplet.kasm-server](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_firewall.workspaces-fw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_loadbalancer.www-lb](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer) | resource |
| [digitalocean_project.project](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project) | resource |
| [digitalocean_record.static](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/record) | resource |
| [digitalocean_tag.project](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/tag) | resource |
| [digitalocean_vpc.kasm_vpc](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc) | resource |
| [digitalocean_certificate.data-cert](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/certificate) | data source |
| [digitalocean_domain.data-default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/domain) | data source |
| [digitalocean_droplet.data-kasm_server](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/droplet) | data source |
| [digitalocean_tag.data-project](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/tag) | data source |
| [digitalocean_vpc.data-kasm_vpc](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The default password to be used for the default admin@kasm.local account. Only use alphanumeric characters | `string` | n/a | yes |
| <a name="input_allow_kasm_web_cidrs"></a> [allow\_kasm\_web\_cidrs](#input\_allow\_kasm\_web\_cidrs) | CIDR notation of the bastion host allowed to SSH in to the machines | `list(string)` | n/a | yes |
| <a name="input_allow_ssh_cidrs"></a> [allow\_ssh\_cidrs](#input\_allow\_ssh\_cidrs) | List of Subnets in CIDR notation for hosts allowed to SSH | `list(string)` | n/a | yes |
| <a name="input_anywhere"></a> [anywhere](#input\_anywhere) | Anywhere route subnet | `list(string)` | <pre>[<br>  "0.0.0.0/0",<br>  "::/0"<br>]</pre> | no |
| <a name="input_digital_ocean_droplet_slug"></a> [digital\_ocean\_droplet\_slug](#input\_digital\_ocean\_droplet\_slug) | The Default Digital Ocean Droplet Slug: https://slugs.do-api.dev/ | `string` | n/a | yes |
| <a name="input_digital_ocean_image"></a> [digital\_ocean\_image](#input\_digital\_ocean\_image) | Default Image for Ubuntu LTS | `string` | n/a | yes |
| <a name="input_digital_ocean_region"></a> [digital\_ocean\_region](#input\_digital\_ocean\_region) | The Default Digital Ocean Region Slug: https://docs.digitalocean.com/products/platform/availability-matrix/ | `string` | n/a | yes |
| <a name="input_do_domain_name"></a> [do\_domain\_name](#input\_do\_domain\_name) | The domain name that users will use to access kasm | `string` | n/a | yes |
| <a name="input_kasm_build_url"></a> [kasm\_build\_url](#input\_kasm\_build\_url) | The Kasm build file to install | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the project/deployment/company eg (acme). Lower case all one word as this will be used in a domain name | `string` | n/a | yes |
| <a name="input_ssh_key_fingerprints"></a> [ssh\_key\_fingerprints](#input\_ssh\_key\_fingerprints) | Keys used for sshing into kasm hosts | `list(string)` | n/a | yes |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The amount of swap (in MB) to configure inside the compute instances | `number` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | The default password to be used for the default user@kasm.local account. Only use alphanumeric characters | `string` | n/a | yes |
| <a name="input_vpc_subnet_cidr"></a> [vpc\_subnet\_cidr](#input\_vpc\_subnet\_cidr) | VPC Subnet CIDR to deploy Kasm | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kasm_server_ip"></a> [kasm\_server\_ip](#output\_kasm\_server\_ip) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
