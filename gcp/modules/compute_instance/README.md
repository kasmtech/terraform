<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.70.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_instance.kasm_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_image.kasm_image](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_stopping_for_update"></a> [allow\_stopping\_for\_update](#input\_allow\_stopping\_for\_update) | Allow GCP service accounts to stop the instance and initiate an updates | `bool` | `false` | no |
| <a name="input_cloud_init_script"></a> [cloud\_init\_script](#input\_cloud\_init\_script) | Startup script used to provision the instance | `list(string)` | n/a | yes |
| <a name="input_enable_instance_vtpm"></a> [enable\_instance\_vtpm](#input\_enable\_instance\_vtpm) | Enable the Trusted Platform Module to secure the instance | `bool` | `true` | no |
| <a name="input_enable_integrity_monitoring"></a> [enable\_integrity\_monitoring](#input\_enable\_integrity\_monitoring) | Enable instance integrity monitoring | `bool` | `true` | no |
| <a name="input_enable_secure_boot"></a> [enable\_secure\_boot](#input\_enable\_secure\_boot) | Enable instance secure boot | `bool` | `null` | no |
| <a name="input_instance_delete_protection"></a> [instance\_delete\_protection](#input\_instance\_delete\_protection) | Prevent instance from accidental deletion | `bool` | `true` | no |
| <a name="input_instance_details"></a> [instance\_details](#input\_instance\_details) | Instance details to configure for Kasm instance | <pre>object({<br>    machine_type     = string<br>    disk_size_gb     = number<br>    instance_role    = string<br>    name             = optional(string, "")<br>    name_prefix      = optional(string, "")<br>    disk_auto_delete = optional(bool, true)<br>    description      = optional(string, null)<br>    disk_type        = optional(string, "pd-balanced")<br>  })</pre> | n/a | yes |
| <a name="input_instance_network"></a> [instance\_network](#input\_instance\_network) | VPC Network self\_link where instance is to be deployed. Usually inferred by the subnetwork, however, if subnetwork names overlap, this can create confusion. This value is optional, and required if subnetwork names are reused across VPCs. | `string` | `null` | no |
| <a name="input_instance_nic_stack_type"></a> [instance\_nic\_stack\_type](#input\_instance\_nic\_stack\_type) | The default network interface type | `string` | `"IPV4_ONLY"` | no |
| <a name="input_instance_nic_type"></a> [instance\_nic\_type](#input\_instance\_nic\_type) | The default network interface type | `string` | `"GVNIC"` | no |
| <a name="input_instance_subnetwork"></a> [instance\_subnetwork](#input\_instance\_subnetwork) | Name of subnetwork where to deploy the instance | `string` | n/a | yes |
| <a name="input_kasm_region"></a> [kasm\_region](#input\_kasm\_region) | GCP region in which to deploy this Kasm instance | `string` | n/a | yes |
| <a name="input_number_of_instances"></a> [number\_of\_instances](#input\_number\_of\_instances) | Number of instances to deploy in this region | `number` | `1` | no |
| <a name="input_public_access_config"></a> [public\_access\_config](#input\_public\_access\_config) | Enable public IP access for instance | <pre>list(object({<br>    nat_ip                 = optional(string)<br>    public_ptr_domain_name = optional(string)<br>    network_tier           = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_resource_labels"></a> [resource\_labels](#input\_resource\_labels) | Labels to apply to the instance | `map(any)` | `null` | no |
| <a name="input_security_tags"></a> [security\_tags](#input\_security\_tags) | Security tags to use with firewall rules to allow instance access | `list(string)` | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service account to use for instance auto updates | <pre>list(object({<br>    email  = optional(string)<br>    scopes = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_source_image"></a> [source\_image](#input\_source\_image) | The source VM Image information to use for deploying Kasm. Recommended to use Ubuntu 20.04 Minimal. You can either explicitly define the source image to use, or the image project and family so that Terraform always chooses the latest. | <pre>list(object({<br>    source_image = optional(string, null)<br>    project      = optional(string, null)<br>    family       = optional(string, null)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Instance private IP address. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Instance public IP address (if applicable) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
