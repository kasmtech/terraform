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

No modules.

## Resources

| Name | Type |
|------|------|
| [google_certificate_manager_certificate.cert](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate) | resource |
| [google_certificate_manager_certificate_map.cert_map](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate_map) | resource |
| [google_certificate_manager_certificate_map_entry.cert_map_entry](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_certificate_map_entry) | resource |
| [google_certificate_manager_dns_authorization.cert_auth](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/certificate_manager_dns_authorization) | resource |
| [google_dns_record_set.cert_dns_record](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_description"></a> [certificate\_description](#input\_certificate\_description) | Certificate description | `string` | `"Global Load Balancer SSL Certificate"` | no |
| <a name="input_certificate_dns_authorization_description"></a> [certificate\_dns\_authorization\_description](#input\_certificate\_dns\_authorization\_description) | Description of the DNS Authorization job in Certificate Manager | `string` | `"Global Load Balancer certificate DNS authorization"` | no |
| <a name="input_certificate_dns_authorization_name"></a> [certificate\_dns\_authorization\_name](#input\_certificate\_dns\_authorization\_name) | The name of the DNS Authorization job in Certificate Manager | `string` | n/a | yes |
| <a name="input_certificate_map_description"></a> [certificate\_map\_description](#input\_certificate\_map\_description) | Description of the certificate map | `string` | `"Global HTTPS Load Balancer Certificate Map"` | no |
| <a name="input_certificate_map_name"></a> [certificate\_map\_name](#input\_certificate\_map\_name) | Certificate map name | `string` | n/a | yes |
| <a name="input_certificate_name"></a> [certificate\_name](#input\_certificate\_name) | Certificate name in Certificate manager. Must be globally unique. | `string` | n/a | yes |
| <a name="input_certificate_scope"></a> [certificate\_scope](#input\_certificate\_scope) | GCP Certificate scope | `string` | `"DEFAULT"` | no |
| <a name="input_create_wildcard"></a> [create\_wildcard](#input\_create\_wildcard) | Add wildcard domain to certificate | `bool` | `true` | no |
| <a name="input_dns_managed_zone_name"></a> [dns\_managed\_zone\_name](#input\_dns\_managed\_zone\_name) | The name of the GCP DNS zone | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Kasm deployment domain name | `string` | n/a | yes |
| <a name="input_resource_labels"></a> [resource\_labels](#input\_resource\_labels) | Labels to add to all created resources in this project | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_map_id"></a> [certificate\_map\_id](#output\_certificate\_map\_id) | The value of the generated certificate map for use with the external load balancer |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
