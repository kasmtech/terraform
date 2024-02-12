# module

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
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.webapp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_lb.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route53_health_check.kasm-elb-hc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check) | resource |
| [aws_route53_record.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route_table.ig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.webapp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.windows](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_security_group.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.private_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.public_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.webapp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.windows](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.private_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.webapp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.windows](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.webapp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.windows](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_elb_service_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb_service_account) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The administrative user password. No special characters | `string` | n/a | yes |
| <a name="input_agent_hdd_size_gb"></a> [agent\_hdd\_size\_gb](#input\_agent\_hdd\_size\_gb) | The HDD size for Kasm Agent nodes | `number` | n/a | yes |
| <a name="input_agent_instance_type"></a> [agent\_instance\_type](#input\_agent\_instance\_type) | The instance type for the Agents | `string` | `"t3.medium"` | no |
| <a name="input_agent_security_rules"></a> [agent\_security\_rules](#input\_agent\_security\_rules) | A map of objects of security rules to apply to the Kasm WebApp server | <pre>map(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>{<br>  "https": {<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| <a name="input_anywhere"></a> [anywhere](#input\_anywhere) | Anywhere route subnet | `string` | `"0.0.0.0/0"` | no |
| <a name="input_aws_domain_name"></a> [aws\_domain\_name](#input\_aws\_domain\_name) | The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https | `string` | n/a | yes |
| <a name="input_aws_key_pair"></a> [aws\_key\_pair](#input\_aws\_key\_pair) | The name of an aws keypair to use. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region for the deployment. (e.g us-east-1) | `string` | n/a | yes |
| <a name="input_aws_ssm_iam_role_name"></a> [aws\_ssm\_iam\_role\_name](#input\_aws\_ssm\_iam\_role\_name) | The name of the SSM EC2 role to associate with Kasm VMs for SSH access | `string` | `""` | no |
| <a name="input_cpx_hdd_size_gb"></a> [cpx\_hdd\_size\_gb](#input\_cpx\_hdd\_size\_gb) | The HDD size for Kasm Guac RDP nodes | `number` | n/a | yes |
| <a name="input_cpx_instance_type"></a> [cpx\_instance\_type](#input\_cpx\_instance\_type) | The instance type for the cpxamole RDP nodes | `string` | `"t3.medium"` | no |
| <a name="input_cpx_security_rules"></a> [cpx\_security\_rules](#input\_cpx\_security\_rules) | A map of objects of security rules to apply to the Kasm Connection Proxy server | <pre>map(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>{<br>  "https": {<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| <a name="input_create_aws_ssm_iam_role"></a> [create\_aws\_ssm\_iam\_role](#input\_create\_aws\_ssm\_iam\_role) | Create an AWS SSM IAM role to attach to VMs for SSH/console access to VMs. | `bool` | `false` | no |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | The password for the database. No special characters | `string` | n/a | yes |
| <a name="input_db_hdd_size_gb"></a> [db\_hdd\_size\_gb](#input\_db\_hdd\_size\_gb) | The HDD size for Kasm DB | `number` | n/a | yes |
| <a name="input_db_instance_type"></a> [db\_instance\_type](#input\_db\_instance\_type) | The instance type for the Database | `string` | `"t3.small"` | no |
| <a name="input_db_security_rules"></a> [db\_security\_rules](#input\_db\_security\_rules) | A map of objects of security rules to apply to the Kasm DB | <pre>map(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>{<br>  "postgres": {<br>    "from_port": 5432,<br>    "protocol": "tcp",<br>    "to_port": 5432<br>  },<br>  "redis": {<br>    "from_port": 6379,<br>    "protocol": "tcp",<br>    "to_port": 6379<br>  }<br>}</pre> | no |
| <a name="input_default_egress"></a> [default\_egress](#input\_default\_egress) | Default egress security rule for all security groups | <pre>object({<br>    from_port    = number<br>    to_port      = number<br>    protocol     = string<br>    cidr_subnets = list(string)<br>  })</pre> | <pre>{<br>  "cidr_subnets": [<br>    "0.0.0.0/0"<br>  ],<br>  "from_port": 0,<br>  "protocol": "-1",<br>  "to_port": 0<br>}</pre> | no |
| <a name="input_ec2_ami"></a> [ec2\_ami](#input\_ec2\_ami) | The AMI used for the EC2 nodes. Recommended Ubuntu 20.04 LTS. | `string` | n/a | yes |
| <a name="input_kasm_build"></a> [kasm\_build](#input\_kasm\_build) | The URL for the Kasm Workspaces build | `string` | n/a | yes |
| <a name="input_kasm_zone_name"></a> [kasm\_zone\_name](#input\_kasm\_zone\_name) | A name given to the kasm deployment Zone | `string` | `"default"` | no |
| <a name="input_manager_token"></a> [manager\_token](#input\_manager\_token) | The manager token value for Agents to authenticate to webapps. No special characters | `string` | n/a | yes |
| <a name="input_num_agents"></a> [num\_agents](#input\_num\_agents) | The number of Agent Role Servers to create in the deployment | `number` | `2` | no |
| <a name="input_num_cpx_nodes"></a> [num\_cpx\_nodes](#input\_num\_cpx\_nodes) | The number of cpx RDP Role Servers to create in the deployment | `number` | `2` | no |
| <a name="input_num_webapps"></a> [num\_webapps](#input\_num\_webapps) | The number of WebApp role servers to create in the deployment | `number` | `2` | no |
| <a name="input_private_lb_security_rules"></a> [private\_lb\_security\_rules](#input\_private\_lb\_security\_rules) | A map of objects of security rules to apply to the Private ALB | <pre>object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  })</pre> | <pre>{<br>  "from_port": 443,<br>  "protocol": "tcp",<br>  "to_port": 443<br>}</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the deployment (e.g dev, staging). A short single word | `string` | n/a | yes |
| <a name="input_public_lb_security_rules"></a> [public\_lb\_security\_rules](#input\_public\_lb\_security\_rules) | A map of objects of security rules to apply to the Public ALB | <pre>map(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>{<br>  "http": {<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "to_port": 80<br>  },<br>  "https": {<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | The password for the Redis server. No special characters | `string` | n/a | yes |
| <a name="input_service_registration_token"></a> [service\_registration\_token](#input\_service\_registration\_token) | The service registration token value for cpx RDP servers to authenticate to webapps. No special characters | `string` | n/a | yes |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The amount of swap (in MB) to configure inside the compute instances | `number` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | The standard (non administrator) user password. No special characters | `string` | n/a | yes |
| <a name="input_vpc_subnet_cidr"></a> [vpc\_subnet\_cidr](#input\_vpc\_subnet\_cidr) | The subnet CIDR to use for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_web_access_cidrs"></a> [web\_access\_cidrs](#input\_web\_access\_cidrs) | CIDR notation of the bastion host allowed to SSH in to the machines | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_webapp_hdd_size_gb"></a> [webapp\_hdd\_size\_gb](#input\_webapp\_hdd\_size\_gb) | The HDD size for Kasm Webapp nodes | `number` | n/a | yes |
| <a name="input_webapp_instance_type"></a> [webapp\_instance\_type](#input\_webapp\_instance\_type) | The instance type for the webapps | `string` | `"t3.small"` | no |
| <a name="input_webapp_security_rules"></a> [webapp\_security\_rules](#input\_webapp\_security\_rules) | A map of objects of security rules to apply to the Kasm WebApp server | <pre>object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  })</pre> | <pre>{<br>  "from_port": 443,<br>  "protocol": "tcp",<br>  "to_port": 443<br>}</pre> | no |
| <a name="input_windows_security_rules"></a> [windows\_security\_rules](#input\_windows\_security\_rules) | A map of objects of security rules to apply to the Kasm Windows VMs | <pre>map(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>{<br>  "cpx_api": {<br>    "from_port": 4902,<br>    "protocol": "tcp",<br>    "to_port": 4902<br>  },<br>  "cpx_rdp": {<br>    "from_port": 3389,<br>    "protocol": "tcp",<br>    "to_port": 3389<br>  },<br>  "webapp_api": {<br>    "from_port": 4902,<br>    "protocol": "tcp",<br>    "to_port": 4902<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
