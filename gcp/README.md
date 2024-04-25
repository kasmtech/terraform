# GCP Deployments

Before getting started with this Terraform, ensure the following GCP APIs or services are enabled to prevent any deployment failures or errors.
- [Cloud NAT](https://cloud.google.com/nat/docs/overview)
- [Cloud DNS API](https://console.cloud.google.com/apis/library/dns.googleapis.com)
- [IAM API](https://console.cloud.google.com/apis/library/iam.googleapis.com)
- [Cloud Resource Manager API](https://console.cloud.google.com/apis/library/cloudresourcemanager.googleapis.com)

To run this Terraform, create a GCP Service Account and generate an API key for the account. Use the below permissions as a starting point to allow the account to provision your Kasm deployment.

IAM Permissions (these are likely a little too permissive, but they are a good starting point):
- roles/compute.loadBalancerAdmin
- roles/compute.networkAdmin
- roles/compute.securityAdmin
- roles/compute.instanceAdmin
- roles/iam.serviceAccountCreator
- roles/iam.serviceAccountDeleter
- roles/iam.serviceAccountTokenCreator
- roles/iam.serviceAccountViewer
- roles/servicenetworking.networksAdmin
- roles/dns.admin
- roles/storage.admin
- roles/iam.serviceAccountUser
- roles/iam.security.admin
- roles/iam.serviceAccountKeys.create


For additional information, check out Google's IAM documentation check out these links:
- [Secure IAM](https://cloud.google.com/iam/docs/using-iam-securely)
- [Understanding Service Accounts](https://cloud.google.com/iam/docs/service-account-overview)
- [IAM Resource Hierarchy](https://cloud.google.com/iam/docs/resource-hierarchy-access-control)
- [Predefined IAM Roles](https://cloud.google.com/iam/docs/understanding-roles)



GCP offers a unique Kasm deployment experience. Due to the way they flatten their cloud network architecture, it is possible to use the same terraform deployment for both single and multi-region deployment models. Below, you will find the Terraform variable and module reference, and if you wish to see documentation specific to a Kasm deployment using this Terraform, just click one of the links below.

- [Kasm Multi-Server Deployment](./MULTI_SERVER.md)
- [Kasm Multi-Region Deployment](./MULTI_REGION.md)


<!-- END PRIVATE BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Deploy VPC and network resources

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_agent_instances"></a> [agent\_instances](#module\_agent\_instances) | ./modules/compute_instance | n/a |
| <a name="module_cloud_nat"></a> [cloud\_nat](#module\_cloud\_nat) | terraform-google-modules/cloud-nat/google | ~> 4.0 |
| <a name="module_cpx_instance_group"></a> [cpx\_instance\_group](#module\_cpx\_instance\_group) | terraform-google-modules/vm/google//modules/mig | ~> 8.0 |
| <a name="module_cpx_instance_template"></a> [cpx\_instance\_template](#module\_cpx\_instance\_template) | terraform-google-modules/vm/google//modules/instance_template | ~> 8.0 |
| <a name="module_database_instance"></a> [database\_instance](#module\_database\_instance) | ./modules/compute_instance | n/a |
| <a name="module_dns_private_zone"></a> [dns\_private\_zone](#module\_dns\_private\_zone) | terraform-google-modules/cloud-dns/google | ~> 5.0 |
| <a name="module_dns_public_records"></a> [dns\_public\_records](#module\_dns\_public\_records) | ./modules/dns_records | n/a |
| <a name="module_dns_public_zone"></a> [dns\_public\_zone](#module\_dns\_public\_zone) | terraform-google-modules/cloud-dns/google | ~> 5.0 |
| <a name="module_kasm_autoscale_service_account"></a> [kasm\_autoscale\_service\_account](#module\_kasm\_autoscale\_service\_account) | ./modules/service_account_iam | n/a |
| <a name="module_passwords"></a> [passwords](#module\_passwords) | ./modules/random | n/a |
| <a name="module_public_load_balancer"></a> [public\_load\_balancer](#module\_public\_load\_balancer) | GoogleCloudPlatform/lb-http/google | ~> 9.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | ~> 7.0 |
| <a name="module_webapp_instance_group"></a> [webapp\_instance\_group](#module\_webapp\_instance\_group) | terraform-google-modules/vm/google//modules/mig | ~> 8.0 |
| <a name="module_webapp_instance_template"></a> [webapp\_instance\_template](#module\_webapp\_instance\_template) | terraform-google-modules/vm/google//modules/instance_template | ~> 8.0 |
| <a name="module_webapp_private_load_balancer"></a> [webapp\_private\_load\_balancer](#module\_webapp\_private\_load\_balancer) | ./modules/private_load_balancer | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_agent_install_options"></a> [additional\_agent\_install\_options](#input\_additional\_agent\_install\_options) | Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details. | `list(string)` | `[]` | no |
| <a name="input_additional_cpx_install_options"></a> [additional\_cpx\_install\_options](#input\_additional\_cpx\_install\_options) | Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details. | `list(string)` | `[]` | no |
| <a name="input_additional_database_install_options"></a> [additional\_database\_install\_options](#input\_additional\_database\_install\_options) | Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details. | `list(string)` | `[]` | no |
| <a name="input_additional_kasm_install_options"></a> [additional\_kasm\_install\_options](#input\_additional\_kasm\_install\_options) | Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details. | `list(string)` | <pre>[<br>  "-O"<br>]</pre> | no |
| <a name="input_additional_webapp_install_options"></a> [additional\_webapp\_install\_options](#input\_additional\_webapp\_install\_options) | Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details. | `list(string)` | `[]` | no |
| <a name="input_agent_gpu_enabled"></a> [agent\_gpu\_enabled](#input\_agent\_gpu\_enabled) | Whether or not to automatically install GPU libraries. NOTE: This is useless unless you deploy Kasm agents using a GPU-based instance. | `bool` | `false` | no |
| <a name="input_agent_vm_instance_config"></a> [agent\_vm\_instance\_config](#input\_agent\_vm\_instance\_config) | Agent Compute instance configuration settings | <pre>object({<br>    machine_type     = string<br>    disk_size_gb     = number<br>    instance_role    = string<br>    name             = optional(string)<br>    name_prefix      = optional(string)<br>    disk_auto_delete = optional(bool)<br>    description      = optional(string)<br>    disk_type        = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_compute_service_account"></a> [compute\_service\_account](#input\_compute\_service\_account) | Compute service account to use for CPX autoscaling | <pre>object({<br>    email  = optional(string)<br>    scopes = list(string)<br>  })</pre> | <pre>{<br>  "email": "",<br>  "scopes": [<br>    "cloud-platform"<br>  ]<br>}</pre> | no |
| <a name="input_cpx_autoscale_cool_down_period"></a> [cpx\_autoscale\_cool\_down\_period](#input\_cpx\_autoscale\_cool\_down\_period) | Time in seconds for the autoscale group to wait before evaluating the health of the webapp | `number` | `600` | no |
| <a name="input_cpx_autoscale_max_instances"></a> [cpx\_autoscale\_max\_instances](#input\_cpx\_autoscale\_max\_instances) | CPX Autoscale maximum number of instances | `number` | `5` | no |
| <a name="input_cpx_autoscale_min_instances"></a> [cpx\_autoscale\_min\_instances](#input\_cpx\_autoscale\_min\_instances) | CPX Autoscale minimum number of instances | `number` | `1` | no |
| <a name="input_cpx_autoscale_scale_in_settings"></a> [cpx\_autoscale\_scale\_in\_settings](#input\_cpx\_autoscale\_scale\_in\_settings) | CPX Autoscale scale-in settings | <pre>object({<br>    fixed_replicas   = number<br>    time_window_sec  = number<br>    percent_replicas = optional(number, null)<br>  })</pre> | <pre>{<br>  "fixed_replicas": 1,<br>  "time_window_sec": 600<br>}</pre> | no |
| <a name="input_cpx_autoscale_scale_out_cpu"></a> [cpx\_autoscale\_scale\_out\_cpu](#input\_cpx\_autoscale\_scale\_out\_cpu) | CPX Autoscale CPU percent to scale up webapps | <pre>list(object({<br>    target            = number<br>    predictive_method = optional(string, "NONE")<br>  }))</pre> | <pre>[<br>  {<br>    "target": 0.6<br>  }<br>]</pre> | no |
| <a name="input_cpx_hostname_prefix"></a> [cpx\_hostname\_prefix](#input\_cpx\_hostname\_prefix) | CPX hostname prefix to use for instance group | `string` | `"cpx"` | no |
| <a name="input_cpx_instance_update_policy"></a> [cpx\_instance\_update\_policy](#input\_cpx\_instance\_update\_policy) | The CPX Instance group rolling update policy | <pre>list(object({<br>    instance_redistribution_type = string<br>    min_ready_sec                = number<br>    replacement_method           = string<br>    minimal_action               = string<br>    type                         = string<br>    max_surge_fixed              = optional(number, null)<br>    max_surge_percent            = optional(number, null) # Can only use if you run 10 or more instances<br>    max_unavailable_fixed        = optional(number, null)<br>    max_unavailable_percent      = optional(number, null) # Can only use if you run 10 or more instances<br>  }))</pre> | <pre>[<br>  {<br>    "instance_redistribution_type": "PROACTIVE",<br>    "max_surge_fixed": 3,<br>    "max_unavailable_fixed": 0,<br>    "min_ready_sec": 600,<br>    "minimal_action": "REFRESH",<br>    "replacement_method": "SUBSTITUTE",<br>    "type": "PROACTIVE"<br>  }<br>]</pre> | no |
| <a name="input_cpx_named_ports"></a> [cpx\_named\_ports](#input\_cpx\_named\_ports) | CPX named ports for firewall and Google service connectivity | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | <pre>[<br>  {<br>    "name": "https",<br>    "port": 443<br>  }<br>]</pre> | no |
| <a name="input_cpx_vm_instance_config"></a> [cpx\_vm\_instance\_config](#input\_cpx\_vm\_instance\_config) | CPX Compute instance configuration settings | <pre>object({<br>    machine_type = string<br>    disk_size_gb = string<br>    disk_type    = string<br>  })</pre> | n/a | yes |
| <a name="input_create_kasm_autoscale_service_account"></a> [create\_kasm\_autoscale\_service\_account](#input\_create\_kasm\_autoscale\_service\_account) | Create a GCP service account capable of managing Kasm Cloud Autoscaling for GCP agents | `bool` | `false` | no |
| <a name="input_create_public_dns_zone"></a> [create\_public\_dns\_zone](#input\_create\_public\_dns\_zone) | Set to true if you wish to create a public DNS zone for this Kasm instance. If not, the public\_dns\_friendly\_name should belong to an existing DNS zone. | `bool` | `true` | no |
| <a name="input_custom_firewall_rules"></a> [custom\_firewall\_rules](#input\_custom\_firewall\_rules) | Additional, custom firewall rules | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    direction               = optional(string, null)<br>    priority                = optional(number, null)<br>    ranges                  = optional(list(string), null)<br>    source_tags             = optional(list(string), null)<br>    source_service_accounts = optional(list(string), null)<br>    target_tags             = optional(list(string), null)<br>    target_service_accounts = optional(list(string), null)<br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), null)<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), null)<br>    log_config = optional(object({<br>      metadata = string<br>    }), null)<br>  }))</pre> | `[]` | no |
| <a name="input_custom_kasm_routes"></a> [custom\_kasm\_routes](#input\_custom\_kasm\_routes) | Custom routes to add to VPC | <pre>list(object({<br>    name                   = string<br>    destination_range      = string<br>    description            = optional(string, null)<br>    priority               = optional(number, null)<br>    next_hop_internet      = optional(bool, false)<br>    next_hop_ip            = optional(string, null)<br>    next_hop_instance      = optional(string, null)<br>    next_hop_instance_zone = optional(string, null)<br>    next_hop_vpn_tunnel    = optional(string, null)<br>    next_hop_ilb           = optional(string, null)<br>    tags                   = optional(list(string), [])<br>  }))</pre> | `[]` | no |
| <a name="input_database_vm_instance_config"></a> [database\_vm\_instance\_config](#input\_database\_vm\_instance\_config) | Database Compute instance configuration settings | <pre>object({<br>    machine_type     = string<br>    disk_size_gb     = number<br>    instance_role    = string<br>    name             = optional(string)<br>    name_prefix      = optional(string)<br>    disk_auto_delete = optional(bool)<br>    description      = optional(string)<br>    disk_type        = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_deploy_connection_proxy"></a> [deploy\_connection\_proxy](#input\_deploy\_connection\_proxy) | Deploy Kasm Guacamole Server for RDP/SSH access to physical servers | `bool` | `false` | no |
| <a name="input_deploy_windows_hosts"></a> [deploy\_windows\_hosts](#input\_deploy\_windows\_hosts) | Create a subnet and Firewall rules for Windows hosts. These hosts must be deployed manually, or you'll need to add your own compute entry for Windows hosts. | `bool` | `false` | no |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | The deployment type - Single-Server, Multi-Server, or Multi-Region | `string` | `"Multi-Server"` | no |
| <a name="input_enable_agent_nat_gateway"></a> [enable\_agent\_nat\_gateway](#input\_enable\_agent\_nat\_gateway) | Deploy Kasm Agent behind a NAT gateway | `bool` | `false` | no |
| <a name="input_google_credential_file_path"></a> [google\_credential\_file\_path](#input\_google\_credential\_file\_path) | File path to GCP account authentication file | `string` | `""` | no |
| <a name="input_kasm_admin_password"></a> [kasm\_admin\_password](#input\_kasm\_admin\_password) | The administrative user password. No special characters | `string` | `""` | no |
| <a name="input_kasm_cert_map_base_name"></a> [kasm\_cert\_map\_base\_name](#input\_kasm\_cert\_map\_base\_name) | Name to use for Kasm Global SSL certificate map | `string` | `"kasm-global-certificate-map"` | no |
| <a name="input_kasm_certificate_base_name"></a> [kasm\_certificate\_base\_name](#input\_kasm\_certificate\_base\_name) | Name to use for Kasm Global SSL certificate | `string` | `"kasm-global-tls-certificate"` | no |
| <a name="input_kasm_certificate_dns_auth_base_name"></a> [kasm\_certificate\_dns\_auth\_base\_name](#input\_kasm\_certificate\_dns\_auth\_base\_name) | Name to use for Kasm SSL DNS authorization service | `string` | `"kasm-global-certificate-dns-authorization"` | no |
| <a name="input_kasm_database_password"></a> [kasm\_database\_password](#input\_kasm\_database\_password) | The password for the database. No special characters | `string` | `""` | no |
| <a name="input_kasm_deployment_regions"></a> [kasm\_deployment\_regions](#input\_kasm\_deployment\_regions) | Kasm regions to deploy into | `list(string)` | n/a | yes |
| <a name="input_kasm_domain_name"></a> [kasm\_domain\_name](#input\_kasm\_domain\_name) | Public DNS domain name to use for Kasm deployment | `string` | n/a | yes |
| <a name="input_kasm_download_url"></a> [kasm\_download\_url](#input\_kasm\_download\_url) | Download URL for Kasm Workspaces installer | `string` | n/a | yes |
| <a name="input_kasm_firewall_security_tags"></a> [kasm\_firewall\_security\_tags](#input\_kasm\_firewall\_security\_tags) | Firewall tags to use for Kasm CPX firewall rules | <pre>object({<br>    webapp   = list(string)<br>    database = list(string)<br>    agent    = list(string)<br>    cpx      = optional(list(string), [])<br>    windows  = optional(list(string), [])<br>  })</pre> | <pre>{<br>  "agent": [<br>    "kasm-agent"<br>  ],<br>  "cpx": [<br>    "kasm-cpx"<br>  ],<br>  "database": [<br>    "database"<br>  ],<br>  "webapp": [<br>    "webapp"<br>  ],<br>  "windows": [<br>    "kasm-windows"<br>  ]<br>}</pre> | no |
| <a name="input_kasm_manager_token"></a> [kasm\_manager\_token](#input\_kasm\_manager\_token) | The manager token value for Agents to authenticate to webapps. No special characters | `string` | `""` | no |
| <a name="input_kasm_project_name"></a> [kasm\_project\_name](#input\_kasm\_project\_name) | Kasm deployment project name (separate from GCP Project id or Project Name) | `string` | `""` | no |
| <a name="input_kasm_redis_password"></a> [kasm\_redis\_password](#input\_kasm\_redis\_password) | The password for the Redis server. No special characters | `string` | `""` | no |
| <a name="input_kasm_service_token"></a> [kasm\_service\_token](#input\_kasm\_service\_token) | The service registration token value for Guac RDP servers to authenticate to webapps. No special characters | `string` | `""` | no |
| <a name="input_kasm_source_image"></a> [kasm\_source\_image](#input\_kasm\_source\_image) | The source VM Image information to use for deploying Kasm. Recommended to use Ubuntu 20.04 Minimal. You can either explicitly define the source image to use, or the image project and family so that Terraform always chooses the latest. | <pre>object({<br>    source_image = optional(string, null)<br>    project      = optional(string, null)<br>    family       = optional(string, null)<br>  })</pre> | <pre>{<br>  "family": "ubuntu-minimal-2004-lts",<br>  "project": "ubuntu-os-cloud"<br>}</pre> | no |
| <a name="input_kasm_user_password"></a> [kasm\_user\_password](#input\_kasm\_user\_password) | The standard (non administrator) user password. No special characters | `string` | `""` | no |
| <a name="input_kasm_version"></a> [kasm\_version](#input\_kasm\_version) | Kasm version to deploy | `string` | `""` | no |
| <a name="input_kasm_vpc_subnet"></a> [kasm\_vpc\_subnet](#input\_kasm\_vpc\_subnet) | VPC Subnet CIDR range. All other Subnets will be automatically calculated from this seed value. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_number_of_agents_per_region"></a> [number\_of\_agents\_per\_region](#input\_number\_of\_agents\_per\_region) | The number of static Kasm agents to deploy in each region. Set this to 0 to | `number` | n/a | yes |
| <a name="input_private_dns_friendly_name"></a> [private\_dns\_friendly\_name](#input\_private\_dns\_friendly\_name) | Private DNS Zone resource name | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID where to deploy Kasm | `string` | n/a | yes |
| <a name="input_public_dns_friendly_name"></a> [public\_dns\_friendly\_name](#input\_public\_dns\_friendly\_name) | Public DNS Zone resource name. If not creating a new DNS Zone, make sure the desired DNS zone already exists. | `string` | n/a | yes |
| <a name="input_public_load_balancer_name"></a> [public\_load\_balancer\_name](#input\_public\_load\_balancer\_name) | GCP name for Global Public HTTPS Load balancer | `string` | `"webapp-global-load-balancer"` | no |
| <a name="input_resource_labels"></a> [resource\_labels](#input\_resource\_labels) | Default tags to add to Terraform-deployed Kasm services | `map(any)` | `null` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | Account name to use for Kasm Autoscaling service account | `string` | `""` | no |
| <a name="input_show_passwords"></a> [show\_passwords](#input\_show\_passwords) | Show Kasm passwords in root Terraform output | `bool` | `true` | no |
| <a name="input_show_sa_credentials"></a> [show\_sa\_credentials](#input\_show\_sa\_credentials) | Show GCP Service account credential file in output | `bool` | `true` | no |
| <a name="input_use_gcp_certificate_manager"></a> [use\_gcp\_certificate\_manager](#input\_use\_gcp\_certificate\_manager) | Use Certificate Manager to create and manage the Kasm public SSL certificate | `bool` | `false` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name for Kasm VPC | `string` | n/a | yes |
| <a name="input_webapp_autoscale_cool_down_period"></a> [webapp\_autoscale\_cool\_down\_period](#input\_webapp\_autoscale\_cool\_down\_period) | Time in seconds for the autoscale group to wait before evaluating the health of the webapp | `number` | `600` | no |
| <a name="input_webapp_autoscale_max_instances"></a> [webapp\_autoscale\_max\_instances](#input\_webapp\_autoscale\_max\_instances) | Webapp Autoscale maximum number of instances | `number` | `5` | no |
| <a name="input_webapp_autoscale_min_instances"></a> [webapp\_autoscale\_min\_instances](#input\_webapp\_autoscale\_min\_instances) | Webapp Autoscale minimum number of instances | `number` | `2` | no |
| <a name="input_webapp_autoscale_scale_in_settings"></a> [webapp\_autoscale\_scale\_in\_settings](#input\_webapp\_autoscale\_scale\_in\_settings) | Webapp Autoscale scale-in settings | <pre>object({<br>    fixed_replicas   = number<br>    time_window_sec  = number<br>    percent_replicas = optional(number, null)<br>  })</pre> | <pre>{<br>  "fixed_replicas": 1,<br>  "time_window_sec": 600<br>}</pre> | no |
| <a name="input_webapp_autoscale_scale_out_cpu"></a> [webapp\_autoscale\_scale\_out\_cpu](#input\_webapp\_autoscale\_scale\_out\_cpu) | Webapp Autoscale CPU percent to scale up webapps | <pre>list(object({<br>    target            = number<br>    predictive_method = string<br>  }))</pre> | <pre>[<br>  {<br>    "predictive_method": "NONE",<br>    "target": 0.6<br>  }<br>]</pre> | no |
| <a name="input_webapp_health_check"></a> [webapp\_health\_check](#input\_webapp\_health\_check) | HTTPS Managed Instance Group healthcheck for webapps. | <pre>object({<br>    type                = string<br>    initial_delay_sec   = number<br>    check_interval_sec  = number<br>    healthy_threshold   = number<br>    timeout_sec         = number<br>    unhealthy_threshold = number<br>    port                = number<br>    port_name           = string<br>    request_path        = string<br>    response            = optional(string, "")<br>    proxy_header        = optional(string, "NONE")<br>    request             = optional(string, "")<br>    host                = optional(string, "")<br>    enable_log          = optional(bool, false)<br>    enable_logging      = optional(string, false)<br>  })</pre> | <pre>{<br>  "check_interval_sec": 30,<br>  "healthy_threshold": 2,<br>  "initial_delay_sec": 600,<br>  "port": 443,<br>  "port_name": "https",<br>  "request_path": "/api/__healthcheck",<br>  "timeout_sec": 10,<br>  "type": "https",<br>  "unhealthy_threshold": 5<br>}</pre> | no |
| <a name="input_webapp_health_check_name"></a> [webapp\_health\_check\_name](#input\_webapp\_health\_check\_name) | Name of Webapp Managed Instance Group healthcheck | `string` | `"webapp-healthcheck"` | no |
| <a name="input_webapp_hostname_prefix"></a> [webapp\_hostname\_prefix](#input\_webapp\_hostname\_prefix) | Webapp hostname prefix to use for instance group | `string` | `"webapp"` | no |
| <a name="input_webapp_instance_update_policy"></a> [webapp\_instance\_update\_policy](#input\_webapp\_instance\_update\_policy) | The Instance group rolling update policy | <pre>list(object({<br>    instance_redistribution_type = string<br>    min_ready_sec                = number<br>    replacement_method           = string<br>    minimal_action               = string<br>    type                         = string<br>    max_surge_fixed              = optional(number, null)<br>    max_surge_percent            = optional(number, null) # Can only use if you run 10 or more instances<br>    max_unavailable_fixed        = optional(number, null)<br>    max_unavailable_percent      = optional(number, null) # Can only use if you run 10 or more instances<br>  }))</pre> | <pre>[<br>  {<br>    "instance_redistribution_type": "PROACTIVE",<br>    "max_surge_fixed": 3,<br>    "max_unavailable_fixed": 0,<br>    "min_ready_sec": 600,<br>    "minimal_action": "REFRESH",<br>    "replacement_method": "SUBSTITUTE",<br>    "type": "PROACTIVE"<br>  }<br>]</pre> | no |
| <a name="input_webapp_lb_health_check"></a> [webapp\_lb\_health\_check](#input\_webapp\_lb\_health\_check) | HTTPS Load balancer and healthcheck for webapps. | <pre>object({<br>    check_interval_sec  = optional(number)<br>    timeout_sec         = optional(number)<br>    healthy_threshold   = optional(number)<br>    unhealthy_threshold = optional(number)<br>    request_path        = optional(string)<br>    port                = optional(number)<br>    host                = optional(string)<br>    logging             = optional(bool)<br>  })</pre> | <pre>{<br>  "check_interval_sec": 30,<br>  "healthy_threshold": 2,<br>  "port": 443,<br>  "request_path": "/api/__healthcheck",<br>  "timeout_sec": 10,<br>  "unhealthy_threshold": 3<br>}</pre> | no |
| <a name="input_webapp_named_ports"></a> [webapp\_named\_ports](#input\_webapp\_named\_ports) | Webapp named ports for firewall and Google service connectivity | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | <pre>[<br>  {<br>    "name": "https",<br>    "port": 443<br>  }<br>]</pre> | no |
| <a name="input_webapp_vm_instance_config"></a> [webapp\_vm\_instance\_config](#input\_webapp\_vm\_instance\_config) | Webapp Compute instance configuration settings | <pre>object({<br>    machine_type = string<br>    disk_size_gb = string<br>    disk_type    = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kasm_passwords"></a> [kasm\_passwords](#output\_kasm\_passwords) | Kasm login passwords |
| <a name="output_kasm_sa_account"></a> [kasm\_sa\_account](#output\_kasm\_sa\_account) | Kasm Service Account connection details |
<!-- END PRIVATE END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Deploy VPC and network resources

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_agent_instances"></a> [agent\_instances](#module\_agent\_instances) | ./modules/compute_instance | n/a |
| <a name="module_cloud_nat"></a> [cloud\_nat](#module\_cloud\_nat) | terraform-google-modules/cloud-nat/google | ~> 4.0 |
| <a name="module_cpx_instance_group"></a> [cpx\_instance\_group](#module\_cpx\_instance\_group) | terraform-google-modules/vm/google//modules/mig | ~> 8.0 |
| <a name="module_cpx_instance_template"></a> [cpx\_instance\_template](#module\_cpx\_instance\_template) | terraform-google-modules/vm/google//modules/instance_template | ~> 8.0 |
| <a name="module_database_instance"></a> [database\_instance](#module\_database\_instance) | ./modules/compute_instance | n/a |
| <a name="module_dns_private_zone"></a> [dns\_private\_zone](#module\_dns\_private\_zone) | terraform-google-modules/cloud-dns/google | ~> 5.0 |
| <a name="module_dns_public_records"></a> [dns\_public\_records](#module\_dns\_public\_records) | ./modules/dns_records | n/a |
| <a name="module_dns_public_zone"></a> [dns\_public\_zone](#module\_dns\_public\_zone) | terraform-google-modules/cloud-dns/google | ~> 5.0 |
| <a name="module_kasm_autoscale_service_account"></a> [kasm\_autoscale\_service\_account](#module\_kasm\_autoscale\_service\_account) | ./modules/service_account_iam | n/a |
| <a name="module_passwords"></a> [passwords](#module\_passwords) | ./modules/random | n/a |
| <a name="module_public_load_balancer"></a> [public\_load\_balancer](#module\_public\_load\_balancer) | GoogleCloudPlatform/lb-http/google | ~> 9.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | ~> 7.0 |
| <a name="module_webapp_instance_group"></a> [webapp\_instance\_group](#module\_webapp\_instance\_group) | terraform-google-modules/vm/google//modules/mig | ~> 8.0 |
| <a name="module_webapp_instance_template"></a> [webapp\_instance\_template](#module\_webapp\_instance\_template) | terraform-google-modules/vm/google//modules/instance_template | ~> 8.0 |
| <a name="module_webapp_private_load_balancer"></a> [webapp\_private\_load\_balancer](#module\_webapp\_private\_load\_balancer) | ./modules/private_load_balancer | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_agent_install_options"></a> [additional\_agent\_install\_options](#input\_additional\_agent\_install\_options) | Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details. | `list(string)` | `[]` | no |
| <a name="input_additional_cpx_install_options"></a> [additional\_cpx\_install\_options](#input\_additional\_cpx\_install\_options) | Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details. | `list(string)` | `[]` | no |
| <a name="input_additional_database_install_options"></a> [additional\_database\_install\_options](#input\_additional\_database\_install\_options) | Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details. | `list(string)` | `[]` | no |
| <a name="input_additional_kasm_install_options"></a> [additional\_kasm\_install\_options](#input\_additional\_kasm\_install\_options) | Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details. | `list(string)` | <pre>[<br>  "-O"<br>]</pre> | no |
| <a name="input_additional_webapp_install_options"></a> [additional\_webapp\_install\_options](#input\_additional\_webapp\_install\_options) | Additional global Kasm install options. Refer to the install.sh file in the Kasm installer for additional details. | `list(string)` | `[]` | no |
| <a name="input_agent_gpu_enabled"></a> [agent\_gpu\_enabled](#input\_agent\_gpu\_enabled) | Whether or not to automatically install GPU libraries. NOTE: This is useless unless you deploy Kasm agents using a GPU-based instance. | `bool` | `false` | no |
| <a name="input_agent_vm_instance_config"></a> [agent\_vm\_instance\_config](#input\_agent\_vm\_instance\_config) | Agent Compute instance configuration settings | <pre>object({<br>    machine_type     = string<br>    disk_size_gb     = number<br>    instance_role    = string<br>    name             = optional(string)<br>    name_prefix      = optional(string)<br>    disk_auto_delete = optional(bool)<br>    description      = optional(string)<br>    disk_type        = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_compute_service_account"></a> [compute\_service\_account](#input\_compute\_service\_account) | Compute service account to use for CPX autoscaling | <pre>object({<br>    email  = optional(string)<br>    scopes = list(string)<br>  })</pre> | <pre>{<br>  "email": "",<br>  "scopes": [<br>    "cloud-platform"<br>  ]<br>}</pre> | no |
| <a name="input_cpx_autoscale_cool_down_period"></a> [cpx\_autoscale\_cool\_down\_period](#input\_cpx\_autoscale\_cool\_down\_period) | Time in seconds for the autoscale group to wait before evaluating the health of the webapp | `number` | `600` | no |
| <a name="input_cpx_autoscale_max_instances"></a> [cpx\_autoscale\_max\_instances](#input\_cpx\_autoscale\_max\_instances) | CPX Autoscale maximum number of instances | `number` | `5` | no |
| <a name="input_cpx_autoscale_min_instances"></a> [cpx\_autoscale\_min\_instances](#input\_cpx\_autoscale\_min\_instances) | CPX Autoscale minimum number of instances | `number` | `1` | no |
| <a name="input_cpx_autoscale_scale_in_settings"></a> [cpx\_autoscale\_scale\_in\_settings](#input\_cpx\_autoscale\_scale\_in\_settings) | CPX Autoscale scale-in settings | <pre>object({<br>    fixed_replicas   = number<br>    time_window_sec  = number<br>    percent_replicas = optional(number, null)<br>  })</pre> | <pre>{<br>  "fixed_replicas": 1,<br>  "time_window_sec": 600<br>}</pre> | no |
| <a name="input_cpx_autoscale_scale_out_cpu"></a> [cpx\_autoscale\_scale\_out\_cpu](#input\_cpx\_autoscale\_scale\_out\_cpu) | CPX Autoscale CPU percent to scale up webapps | <pre>list(object({<br>    target            = number<br>    predictive_method = optional(string, "NONE")<br>  }))</pre> | <pre>[<br>  {<br>    "target": 0.6<br>  }<br>]</pre> | no |
| <a name="input_cpx_hostname_prefix"></a> [cpx\_hostname\_prefix](#input\_cpx\_hostname\_prefix) | CPX hostname prefix to use for instance group | `string` | `"cpx"` | no |
| <a name="input_cpx_instance_update_policy"></a> [cpx\_instance\_update\_policy](#input\_cpx\_instance\_update\_policy) | The CPX Instance group rolling update policy | <pre>list(object({<br>    instance_redistribution_type = string<br>    min_ready_sec                = number<br>    replacement_method           = string<br>    minimal_action               = string<br>    type                         = string<br>    max_surge_fixed              = optional(number, null)<br>    max_surge_percent            = optional(number, null) # Can only use if you run 10 or more instances<br>    max_unavailable_fixed        = optional(number, null)<br>    max_unavailable_percent      = optional(number, null) # Can only use if you run 10 or more instances<br>  }))</pre> | <pre>[<br>  {<br>    "instance_redistribution_type": "PROACTIVE",<br>    "max_surge_fixed": 3,<br>    "max_unavailable_fixed": 0,<br>    "min_ready_sec": 600,<br>    "minimal_action": "REFRESH",<br>    "replacement_method": "SUBSTITUTE",<br>    "type": "PROACTIVE"<br>  }<br>]</pre> | no |
| <a name="input_cpx_named_ports"></a> [cpx\_named\_ports](#input\_cpx\_named\_ports) | CPX named ports for firewall and Google service connectivity | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | <pre>[<br>  {<br>    "name": "https",<br>    "port": 443<br>  }<br>]</pre> | no |
| <a name="input_cpx_vm_instance_config"></a> [cpx\_vm\_instance\_config](#input\_cpx\_vm\_instance\_config) | CPX Compute instance configuration settings | <pre>object({<br>    machine_type = string<br>    disk_size_gb = string<br>    disk_type    = string<br>  })</pre> | n/a | yes |
| <a name="input_create_kasm_autoscale_service_account"></a> [create\_kasm\_autoscale\_service\_account](#input\_create\_kasm\_autoscale\_service\_account) | Create a GCP service account capable of managing Kasm Cloud Autoscaling for GCP agents | `bool` | `false` | no |
| <a name="input_create_public_dns_zone"></a> [create\_public\_dns\_zone](#input\_create\_public\_dns\_zone) | Set to true if you wish to create a public DNS zone for this Kasm instance. If not, the public\_dns\_friendly\_name should belong to an existing DNS zone. | `bool` | `true` | no |
| <a name="input_custom_firewall_rules"></a> [custom\_firewall\_rules](#input\_custom\_firewall\_rules) | Additional, custom firewall rules | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    direction               = optional(string, null)<br>    priority                = optional(number, null)<br>    ranges                  = optional(list(string), null)<br>    source_tags             = optional(list(string), null)<br>    source_service_accounts = optional(list(string), null)<br>    target_tags             = optional(list(string), null)<br>    target_service_accounts = optional(list(string), null)<br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), null)<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), null)<br>    log_config = optional(object({<br>      metadata = string<br>    }), null)<br>  }))</pre> | `[]` | no |
| <a name="input_custom_kasm_routes"></a> [custom\_kasm\_routes](#input\_custom\_kasm\_routes) | Custom routes to add to VPC | <pre>list(object({<br>    name                   = string<br>    destination_range      = string<br>    description            = optional(string, null)<br>    priority               = optional(number, null)<br>    next_hop_internet      = optional(bool, false)<br>    next_hop_ip            = optional(string, null)<br>    next_hop_instance      = optional(string, null)<br>    next_hop_instance_zone = optional(string, null)<br>    next_hop_vpn_tunnel    = optional(string, null)<br>    next_hop_ilb           = optional(string, null)<br>    tags                   = optional(list(string), [])<br>  }))</pre> | `[]` | no |
| <a name="input_database_vm_instance_config"></a> [database\_vm\_instance\_config](#input\_database\_vm\_instance\_config) | Database Compute instance configuration settings | <pre>object({<br>    machine_type     = string<br>    disk_size_gb     = number<br>    instance_role    = string<br>    name             = optional(string)<br>    name_prefix      = optional(string)<br>    disk_auto_delete = optional(bool)<br>    description      = optional(string)<br>    disk_type        = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_deploy_connection_proxy"></a> [deploy\_connection\_proxy](#input\_deploy\_connection\_proxy) | Deploy Kasm Guacamole Server for RDP/SSH access to physical servers | `bool` | `false` | no |
| <a name="input_deploy_windows_hosts"></a> [deploy\_windows\_hosts](#input\_deploy\_windows\_hosts) | Create a subnet and Firewall rules for Windows hosts. These hosts must be deployed manually, or you'll need to add your own compute entry for Windows hosts. | `bool` | `false` | no |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | The deployment type - Single-Server, Multi-Server, or Multi-Region | `string` | `"Multi-Server"` | no |
| <a name="input_enable_agent_nat_gateway"></a> [enable\_agent\_nat\_gateway](#input\_enable\_agent\_nat\_gateway) | Deploy Kasm Agent behind a NAT gateway | `bool` | `false` | no |
| <a name="input_google_credential_file_path"></a> [google\_credential\_file\_path](#input\_google\_credential\_file\_path) | File path to GCP account authentication file | `string` | `""` | no |
| <a name="input_kasm_admin_password"></a> [kasm\_admin\_password](#input\_kasm\_admin\_password) | The administrative user password. No special characters | `string` | `""` | no |
| <a name="input_kasm_cert_map_base_name"></a> [kasm\_cert\_map\_base\_name](#input\_kasm\_cert\_map\_base\_name) | Name to use for Kasm Global SSL certificate map | `string` | `"kasm-global-certificate-map"` | no |
| <a name="input_kasm_certificate_base_name"></a> [kasm\_certificate\_base\_name](#input\_kasm\_certificate\_base\_name) | Name to use for Kasm Global SSL certificate | `string` | `"kasm-global-tls-certificate"` | no |
| <a name="input_kasm_certificate_dns_auth_base_name"></a> [kasm\_certificate\_dns\_auth\_base\_name](#input\_kasm\_certificate\_dns\_auth\_base\_name) | Name to use for Kasm SSL DNS authorization service | `string` | `"kasm-global-certificate-dns-authorization"` | no |
| <a name="input_kasm_database_password"></a> [kasm\_database\_password](#input\_kasm\_database\_password) | The password for the database. No special characters | `string` | `""` | no |
| <a name="input_kasm_deployment_regions"></a> [kasm\_deployment\_regions](#input\_kasm\_deployment\_regions) | Kasm regions to deploy into | `list(string)` | n/a | yes |
| <a name="input_kasm_domain_name"></a> [kasm\_domain\_name](#input\_kasm\_domain\_name) | Public DNS domain name to use for Kasm deployment | `string` | n/a | yes |
| <a name="input_kasm_download_url"></a> [kasm\_download\_url](#input\_kasm\_download\_url) | Download URL for Kasm Workspaces installer | `string` | n/a | yes |
| <a name="input_kasm_firewall_security_tags"></a> [kasm\_firewall\_security\_tags](#input\_kasm\_firewall\_security\_tags) | Firewall tags to use for Kasm CPX firewall rules | <pre>object({<br>    webapp   = list(string)<br>    database = list(string)<br>    agent    = list(string)<br>    cpx      = optional(list(string), [])<br>    windows  = optional(list(string), [])<br>  })</pre> | <pre>{<br>  "agent": [<br>    "kasm-agent"<br>  ],<br>  "cpx": [<br>    "kasm-cpx"<br>  ],<br>  "database": [<br>    "database"<br>  ],<br>  "webapp": [<br>    "webapp"<br>  ],<br>  "windows": [<br>    "kasm-windows"<br>  ]<br>}</pre> | no |
| <a name="input_kasm_manager_token"></a> [kasm\_manager\_token](#input\_kasm\_manager\_token) | The manager token value for Agents to authenticate to webapps. No special characters | `string` | `""` | no |
| <a name="input_kasm_project_name"></a> [kasm\_project\_name](#input\_kasm\_project\_name) | Kasm deployment project name (separate from GCP Project id or Project Name) | `string` | `""` | no |
| <a name="input_kasm_redis_password"></a> [kasm\_redis\_password](#input\_kasm\_redis\_password) | The password for the Redis server. No special characters | `string` | `""` | no |
| <a name="input_kasm_service_token"></a> [kasm\_service\_token](#input\_kasm\_service\_token) | The service registration token value for Guac RDP servers to authenticate to webapps. No special characters | `string` | `""` | no |
| <a name="input_kasm_source_image"></a> [kasm\_source\_image](#input\_kasm\_source\_image) | The source VM Image information to use for deploying Kasm. Recommended to use Ubuntu 20.04 Minimal. You can either explicitly define the source image to use, or the image project and family so that Terraform always chooses the latest. | <pre>object({<br>    source_image = optional(string, null)<br>    project      = optional(string, null)<br>    family       = optional(string, null)<br>  })</pre> | <pre>{<br>  "family": "ubuntu-minimal-2004-lts",<br>  "project": "ubuntu-os-cloud"<br>}</pre> | no |
| <a name="input_kasm_user_password"></a> [kasm\_user\_password](#input\_kasm\_user\_password) | The standard (non administrator) user password. No special characters | `string` | `""` | no |
| <a name="input_kasm_version"></a> [kasm\_version](#input\_kasm\_version) | Kasm version to deploy | `string` | `""` | no |
| <a name="input_kasm_vpc_subnet"></a> [kasm\_vpc\_subnet](#input\_kasm\_vpc\_subnet) | VPC Subnet CIDR range. All other Subnets will be automatically calculated from this seed value. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_number_of_agents_per_region"></a> [number\_of\_agents\_per\_region](#input\_number\_of\_agents\_per\_region) | The number of static Kasm agents to deploy in each region. Set this to 0 to | `number` | n/a | yes |
| <a name="input_private_dns_friendly_name"></a> [private\_dns\_friendly\_name](#input\_private\_dns\_friendly\_name) | Private DNS Zone resource name | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID where to deploy Kasm | `string` | n/a | yes |
| <a name="input_public_dns_friendly_name"></a> [public\_dns\_friendly\_name](#input\_public\_dns\_friendly\_name) | Public DNS Zone resource name. If not creating a new DNS Zone, make sure the desired DNS zone already exists. | `string` | n/a | yes |
| <a name="input_public_load_balancer_name"></a> [public\_load\_balancer\_name](#input\_public\_load\_balancer\_name) | GCP name for Global Public HTTPS Load balancer | `string` | `"webapp-global-load-balancer"` | no |
| <a name="input_resource_labels"></a> [resource\_labels](#input\_resource\_labels) | Default tags to add to Terraform-deployed Kasm services | `map(any)` | `null` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | Account name to use for Kasm Autoscaling service account | `string` | `""` | no |
| <a name="input_show_passwords"></a> [show\_passwords](#input\_show\_passwords) | Show Kasm passwords in root Terraform output | `bool` | `true` | no |
| <a name="input_show_sa_credentials"></a> [show\_sa\_credentials](#input\_show\_sa\_credentials) | Show GCP Service account credential file in output | `bool` | `true` | no |
| <a name="input_use_gcp_certificate_manager"></a> [use\_gcp\_certificate\_manager](#input\_use\_gcp\_certificate\_manager) | Use Certificate Manager to create and manage the Kasm public SSL certificate | `bool` | `false` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name for Kasm VPC | `string` | n/a | yes |
| <a name="input_webapp_autoscale_cool_down_period"></a> [webapp\_autoscale\_cool\_down\_period](#input\_webapp\_autoscale\_cool\_down\_period) | Time in seconds for the autoscale group to wait before evaluating the health of the webapp | `number` | `600` | no |
| <a name="input_webapp_autoscale_max_instances"></a> [webapp\_autoscale\_max\_instances](#input\_webapp\_autoscale\_max\_instances) | Webapp Autoscale maximum number of instances | `number` | `5` | no |
| <a name="input_webapp_autoscale_min_instances"></a> [webapp\_autoscale\_min\_instances](#input\_webapp\_autoscale\_min\_instances) | Webapp Autoscale minimum number of instances | `number` | `2` | no |
| <a name="input_webapp_autoscale_scale_in_settings"></a> [webapp\_autoscale\_scale\_in\_settings](#input\_webapp\_autoscale\_scale\_in\_settings) | Webapp Autoscale scale-in settings | <pre>object({<br>    fixed_replicas   = number<br>    time_window_sec  = number<br>    percent_replicas = optional(number, null)<br>  })</pre> | <pre>{<br>  "fixed_replicas": 1,<br>  "time_window_sec": 600<br>}</pre> | no |
| <a name="input_webapp_autoscale_scale_out_cpu"></a> [webapp\_autoscale\_scale\_out\_cpu](#input\_webapp\_autoscale\_scale\_out\_cpu) | Webapp Autoscale CPU percent to scale up webapps | <pre>list(object({<br>    target            = number<br>    predictive_method = string<br>  }))</pre> | <pre>[<br>  {<br>    "predictive_method": "NONE",<br>    "target": 0.6<br>  }<br>]</pre> | no |
| <a name="input_webapp_health_check"></a> [webapp\_health\_check](#input\_webapp\_health\_check) | HTTPS Managed Instance Group healthcheck for webapps. | <pre>object({<br>    type                = string<br>    initial_delay_sec   = number<br>    check_interval_sec  = number<br>    healthy_threshold   = number<br>    timeout_sec         = number<br>    unhealthy_threshold = number<br>    port                = number<br>    port_name           = string<br>    request_path        = string<br>    response            = optional(string, "")<br>    proxy_header        = optional(string, "NONE")<br>    request             = optional(string, "")<br>    host                = optional(string, "")<br>    enable_log          = optional(bool, false)<br>    enable_logging      = optional(string, false)<br>  })</pre> | <pre>{<br>  "check_interval_sec": 30,<br>  "healthy_threshold": 2,<br>  "initial_delay_sec": 600,<br>  "port": 443,<br>  "port_name": "https",<br>  "request_path": "/api/__healthcheck",<br>  "timeout_sec": 10,<br>  "type": "https",<br>  "unhealthy_threshold": 5<br>}</pre> | no |
| <a name="input_webapp_health_check_name"></a> [webapp\_health\_check\_name](#input\_webapp\_health\_check\_name) | Name of Webapp Managed Instance Group healthcheck | `string` | `"webapp-healthcheck"` | no |
| <a name="input_webapp_hostname_prefix"></a> [webapp\_hostname\_prefix](#input\_webapp\_hostname\_prefix) | Webapp hostname prefix to use for instance group | `string` | `"webapp"` | no |
| <a name="input_webapp_instance_update_policy"></a> [webapp\_instance\_update\_policy](#input\_webapp\_instance\_update\_policy) | The Instance group rolling update policy | <pre>list(object({<br>    instance_redistribution_type = string<br>    min_ready_sec                = number<br>    replacement_method           = string<br>    minimal_action               = string<br>    type                         = string<br>    max_surge_fixed              = optional(number, null)<br>    max_surge_percent            = optional(number, null) # Can only use if you run 10 or more instances<br>    max_unavailable_fixed        = optional(number, null)<br>    max_unavailable_percent      = optional(number, null) # Can only use if you run 10 or more instances<br>  }))</pre> | <pre>[<br>  {<br>    "instance_redistribution_type": "PROACTIVE",<br>    "max_surge_fixed": 3,<br>    "max_unavailable_fixed": 0,<br>    "min_ready_sec": 600,<br>    "minimal_action": "REFRESH",<br>    "replacement_method": "SUBSTITUTE",<br>    "type": "PROACTIVE"<br>  }<br>]</pre> | no |
| <a name="input_webapp_lb_health_check"></a> [webapp\_lb\_health\_check](#input\_webapp\_lb\_health\_check) | HTTPS Load balancer and healthcheck for webapps. | <pre>object({<br>    check_interval_sec  = optional(number)<br>    timeout_sec         = optional(number)<br>    healthy_threshold   = optional(number)<br>    unhealthy_threshold = optional(number)<br>    request_path        = optional(string)<br>    port                = optional(number)<br>    host                = optional(string)<br>    logging             = optional(bool)<br>  })</pre> | <pre>{<br>  "check_interval_sec": 30,<br>  "healthy_threshold": 2,<br>  "port": 443,<br>  "request_path": "/api/__healthcheck",<br>  "timeout_sec": 10,<br>  "unhealthy_threshold": 3<br>}</pre> | no |
| <a name="input_webapp_named_ports"></a> [webapp\_named\_ports](#input\_webapp\_named\_ports) | Webapp named ports for firewall and Google service connectivity | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | <pre>[<br>  {<br>    "name": "https",<br>    "port": 443<br>  }<br>]</pre> | no |
| <a name="input_webapp_vm_instance_config"></a> [webapp\_vm\_instance\_config](#input\_webapp\_vm\_instance\_config) | Webapp Compute instance configuration settings | <pre>object({<br>    machine_type = string<br>    disk_size_gb = string<br>    disk_type    = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kasm_passwords"></a> [kasm\_passwords](#output\_kasm\_passwords) | Kasm login passwords |
| <a name="output_kasm_sa_account"></a> [kasm\_sa\_account](#output\_kasm\_sa\_account) | Kasm Service Account connection details |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
