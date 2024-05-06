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
| [google_compute_forwarding_rule.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_region_backend_service.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_backend_service) | resource |
| [google_compute_region_health_check.tcp](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_health_check) | resource |
| [google_compute_region_target_tcp_proxy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_target_tcp_proxy) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_compute_subnetwork.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_timeout_sec"></a> [backend\_timeout\_sec](#input\_backend\_timeout\_sec) | Backend timeout | `number` | `30` | no |
| <a name="input_backends"></a> [backends](#input\_backends) | List of backends, should be a map of key-value pairs for each backend, must have the 'group' key. | `list(any)` | n/a | yes |
| <a name="input_connection_draining_timeout_sec"></a> [connection\_draining\_timeout\_sec](#input\_connection\_draining\_timeout\_sec) | Time for which instance will be drained | `number` | `300` | no |
| <a name="input_global_access"></a> [global\_access](#input\_global\_access) | Allow all regions on the same VPC network access. | `bool` | `false` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | Health check to determine whether instances are responsive and able to do work | <pre>object({<br>    type                = string<br>    check_interval_sec  = number<br>    healthy_threshold   = number<br>    timeout_sec         = number<br>    unhealthy_threshold = number<br>    response            = string<br>    proxy_header        = string<br>    port                = number<br>    port_name           = string<br>    request             = string<br>    request_path        = string<br>    host                = string<br>    enable_log          = bool<br>  })</pre> | n/a | yes |
| <a name="input_ip_protocol"></a> [ip\_protocol](#input\_ip\_protocol) | The IP protocol for the backend and frontend forwarding rule. TCP or UDP. | `string` | `"TCP"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | The labels to attach to resources created by this module. | `map(string)` | `{}` | no |
| <a name="input_load_balancing_policy"></a> [load\_balancing\_policy](#input\_load\_balancing\_policy) | The load balancing policy to use | `string` | `"ROUND_ROBIN"` | no |
| <a name="input_load_balancing_scheme"></a> [load\_balancing\_scheme](#input\_load\_balancing\_scheme) | The load balancing scheme to use. The default is INTERNAL | `string` | `"INTERNAL_MANAGED"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the forwarding rule and prefix for supporting resources. | `string` | n/a | yes |
| <a name="input_named_port"></a> [named\_port](#input\_named\_port) | Named port to allow access to the LB or resources through the VPC FW | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | Name of the network to create resources in. | `string` | `"default"` | no |
| <a name="input_network_project"></a> [network\_project](#input\_network\_project) | Name of the project for the network. Useful for shared VPC. Default is var.project. | `string` | `""` | no |
| <a name="input_port_range"></a> [port\_range](#input\_port\_range) | List of ports range to forward to backend services. Max is 5. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project to deploy to, if not set the default provider project is used. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | Region for cloud resources. | `string` | n/a | yes |
| <a name="input_session_affinity"></a> [session\_affinity](#input\_session\_affinity) | The session affinity for the backends example: NONE, CLIENT\_IP. Default is `NONE`. | `string` | `"NONE"` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | Name of the subnetwork to create resources in. | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_forwarding_rule"></a> [forwarding\_rule](#output\_forwarding\_rule) | The forwarding rule self\_link. |
| <a name="output_forwarding_rule_id"></a> [forwarding\_rule\_id](#output\_forwarding\_rule\_id) | The forwarding rule id. |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | The internal IP assigned to the regional forwarding rule. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
