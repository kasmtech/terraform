<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.81.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dns_zone_admin"></a> [dns\_zone\_admin](#module\_dns\_zone\_admin) | terraform-google-modules/iam/google//modules/dns_zones_iam | ~> 7.6 |
| <a name="module_service_account_roles"></a> [service\_account\_roles](#module\_service\_account\_roles) | terraform-google-modules/iam/google//modules/member_iam | ~> 7.6 |

## Resources

| Name | Type |
|------|------|
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.kasm_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The account id used to generate the service account email address | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The service account display name | `string` | `""` | no |
| <a name="input_dns_public_zone_name"></a> [dns\_public\_zone\_name](#input\_dns\_public\_zone\_name) | Friendly name of the public DNS zone to manage. Only used if Direct to Agent is enabled. | `string` | `""` | no |
| <a name="input_manage_dns"></a> [manage\_dns](#input\_manage\_dns) | Allow the service account to add/delete DNS records for direct-to-agent. | `bool` | `false` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project id for the zone. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connect_details"></a> [connect\_details](#output\_connect\_details) | Kasm autoscale service account connect JSON output. NOTE: This contains sensitive data! |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
