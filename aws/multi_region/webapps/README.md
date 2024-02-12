# webapps

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.webapp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_route53_health_check.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check) | resource |
| [aws_route53_record.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.latency](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_hdd_size_gb"></a> [agent\_hdd\_size\_gb](#input\_agent\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm Agent instances | `number` | `0` | no |
| <a name="input_agent_instance_type"></a> [agent\_instance\_type](#input\_agent\_instance\_type) | the instance type for the agents | `string` | `""` | no |
| <a name="input_agent_security_group_id"></a> [agent\_security\_group\_id](#input\_agent\_security\_group\_id) | Kasm Agent security group ID | `string` | `""` | no |
| <a name="input_agent_subnet_id"></a> [agent\_subnet\_id](#input\_agent\_subnet\_id) | Subnet ID created for agents | `string` | `""` | no |
| <a name="input_aws_domain_name"></a> [aws\_domain\_name](#input\_aws\_domain\_name) | The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https | `string` | n/a | yes |
| <a name="input_aws_key_pair"></a> [aws\_key\_pair](#input\_aws\_key\_pair) | The name of an aws keypair to use. | `string` | n/a | yes |
| <a name="input_aws_ssm_iam_role_name"></a> [aws\_ssm\_iam\_role\_name](#input\_aws\_ssm\_iam\_role\_name) | The name of the SSM EC2 role to associate with Kasm VMs for SSH access | `string` | `""` | no |
| <a name="input_aws_to_kasm_zone_map"></a> [aws\_to\_kasm\_zone\_map](#input\_aws\_to\_kasm\_zone\_map) | AWS regions mapped to Kasm Deployment Zone names | `map(any)` | <pre>{<br>  "af-south-1": "Africa-(Cape-Town)",<br>  "ap-east-1": "China-(Hong-Kong)",<br>  "ap-northeast-1": "Japan-(Tokyo)",<br>  "ap-northeast-2": "S-Korea-(Seoul)",<br>  "ap-northeast-3": "Japan-(Osaka)",<br>  "ap-south-1": "India-(Mumbai)",<br>  "ap-south-2": "India-(Hyderbad)",<br>  "ap-southeast-1": "Singapore",<br>  "ap-southeast-2": "Austrailia-(Sydney)",<br>  "ap-southeast-3": "Indonesia-(Jakarta)",<br>  "ap-southeast-4": "Austrailia-(Melbourne)",<br>  "ca-central-1": "Canada-(Montreal)",<br>  "eu-central-1": "Switzerland-(Zurich)",<br>  "eu-north-1": "Sweden-(Stockholm)",<br>  "eu-south-1": "Italy-(Milan)",<br>  "eu-south-2": "Spain-(Aragon)",<br>  "eu-west-1": "Ireland-(Dublin)",<br>  "eu-west-2": "UK-(London)",<br>  "eu-west-3": "France-(Paris)",<br>  "me-central-1": "United-Arab-Emirates",<br>  "me-south-1": "Manama-(Bahrain)",<br>  "sa-east-1": "Brazil-(Sao-Paulo)",<br>  "us-east-1": "USA-(Virginia)",<br>  "us-east-2": "USA-(Ohio)",<br>  "us-west-1": "USA-(California)",<br>  "us-west-2": "USA-(Oregon)"<br>}</pre> | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The certificate ARN created in the primary region for use with all load balancers in the deployment. | `string` | n/a | yes |
| <a name="input_cpx_hdd_size_gb"></a> [cpx\_hdd\_size\_gb](#input\_cpx\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm CPX instances | `number` | `0` | no |
| <a name="input_cpx_instance_type"></a> [cpx\_instance\_type](#input\_cpx\_instance\_type) | the instance type for the CPX nodes | `string` | `""` | no |
| <a name="input_cpx_security_group_id"></a> [cpx\_security\_group\_id](#input\_cpx\_security\_group\_id) | CPX security group ID | `string` | `""` | no |
| <a name="input_cpx_subnet_id"></a> [cpx\_subnet\_id](#input\_cpx\_subnet\_id) | Subnet ID created for Kasm CPX nodes | `string` | `""` | no |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | The password for the database. No special characters | `string` | n/a | yes |
| <a name="input_ec2_ami"></a> [ec2\_ami](#input\_ec2\_ami) | The AMI used for the EC2 nodes. Recommended Ubuntu 20.04 LTS. | `string` | n/a | yes |
| <a name="input_faux_aws_region"></a> [faux\_aws\_region](#input\_faux\_aws\_region) | The AWS region this WebApp is supposed to represent even though it will be created in the primary region of the deployment. (e.g us-east-1) | `string` | n/a | yes |
| <a name="input_kasm_build"></a> [kasm\_build](#input\_kasm\_build) | The URL for the Kasm Workspaces build | `string` | n/a | yes |
| <a name="input_kasm_db_ip"></a> [kasm\_db\_ip](#input\_kasm\_db\_ip) | The IP/DNS name of the Kasm database | `string` | n/a | yes |
| <a name="input_load_balancer_log_bucket"></a> [load\_balancer\_log\_bucket](#input\_load\_balancer\_log\_bucket) | S3 bucket name for load balancers to forward access logs to | `string` | n/a | yes |
| <a name="input_load_balancer_security_group_id"></a> [load\_balancer\_security\_group\_id](#input\_load\_balancer\_security\_group\_id) | Security Group ID for the Primary region's load balancer | `string` | n/a | yes |
| <a name="input_load_balancer_subnet_ids"></a> [load\_balancer\_subnet\_ids](#input\_load\_balancer\_subnet\_ids) | ALB subnet IDs created to host webapps in the primary region | `list(string)` | n/a | yes |
| <a name="input_manager_token"></a> [manager\_token](#input\_manager\_token) | The Manager Token used by Kasm Agents to authenticate. No special characters | `string` | n/a | yes |
| <a name="input_num_agents"></a> [num\_agents](#input\_num\_agents) | The number of Agent Role Servers to create in the deployment | `number` | `0` | no |
| <a name="input_num_cpx_nodes"></a> [num\_cpx\_nodes](#input\_num\_cpx\_nodes) | The number of cpx  Role Servers to create in the deployment | `number` | `0` | no |
| <a name="input_num_webapps"></a> [num\_webapps](#input\_num\_webapps) | The number of WebApp role servers to create in the deployment | `number` | n/a | yes |
| <a name="input_primary_aws_region"></a> [primary\_aws\_region](#input\_primary\_aws\_region) | The AWS region for primary region of the deployment. (e.g us-east-1) | `string` | n/a | yes |
| <a name="input_primary_vpc_id"></a> [primary\_vpc\_id](#input\_primary\_vpc\_id) | The VPC ID of the primary region | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the deployment (e.g dev, staging). A short single word | `string` | n/a | yes |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | The password for the database. No special characters | `string` | n/a | yes |
| <a name="input_service_registration_token"></a> [service\_registration\_token](#input\_service\_registration\_token) | The service registration token value for cpx RDP servers to authenticate to webapps. No special characters | `string` | `""` | no |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The amount of swap (in MB) to configure inside the compute instances | `number` | n/a | yes |
| <a name="input_webapp_hdd_size_gb"></a> [webapp\_hdd\_size\_gb](#input\_webapp\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm WebApp instances | `number` | n/a | yes |
| <a name="input_webapp_instance_type"></a> [webapp\_instance\_type](#input\_webapp\_instance\_type) | The instance type for the webapps | `string` | n/a | yes |
| <a name="input_webapp_security_group_id"></a> [webapp\_security\_group\_id](#input\_webapp\_security\_group\_id) | WebApp security group ID | `string` | n/a | yes |
| <a name="input_webapp_subnet_ids"></a> [webapp\_subnet\_ids](#input\_webapp\_subnet\_ids) | WebApp subnet IDs created to host webapps in the primary region | `list(string)` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | A name given to the Kasm deployment Zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kasm_zone_settings"></a> [kasm\_zone\_settings](#output\_kasm\_zone\_settings) | Upstream Auth and Proxy Address settings to apply to Kasm Zone configuration |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
