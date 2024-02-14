# agents

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
| [aws_instance.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route53_record.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route_table.internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.windows](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.public_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.windows](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.agent_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cpx_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.proxy_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.proxy_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.proxy_public_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_lb_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.windows_cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.windows_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.windows_webapp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.cpx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.windows](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_hdd_size_gb"></a> [agent\_hdd\_size\_gb](#input\_agent\_hdd\_size\_gb) | The HDD size for agents | `number` | n/a | yes |
| <a name="input_agent_instance_type"></a> [agent\_instance\_type](#input\_agent\_instance\_type) | The instance type for the agents | `string` | n/a | yes |
| <a name="input_agent_security_rules"></a> [agent\_security\_rules](#input\_agent\_security\_rules) | A map of objects of security rules to apply to the Kasm WebApp server | <pre>map(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>{<br>  "https": {<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| <a name="input_agent_vpc_cidr"></a> [agent\_vpc\_cidr](#input\_agent\_vpc\_cidr) | Subnet CIDR range for Agent VPC | `string` | n/a | yes |
| <a name="input_anywhere"></a> [anywhere](#input\_anywhere) | Anywhere subnet for routing and load ingress from all IPs | `string` | `"0.0.0.0/0"` | no |
| <a name="input_aws_domain_name"></a> [aws\_domain\_name](#input\_aws\_domain\_name) | The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https | `string` | n/a | yes |
| <a name="input_aws_key_pair"></a> [aws\_key\_pair](#input\_aws\_key\_pair) | The name of an aws keypair to use. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region for the deployment. (e.g us-east-1) | `string` | n/a | yes |
| <a name="input_aws_ssm_instance_profile_name"></a> [aws\_ssm\_instance\_profile\_name](#input\_aws\_ssm\_instance\_profile\_name) | The name of the SSM EC2 Instance Profile to associate with Kasm VMs for SSH access | `string` | `""` | no |
| <a name="input_cpx_hdd_size_gb"></a> [cpx\_hdd\_size\_gb](#input\_cpx\_hdd\_size\_gb) | The HDD size for Kasm Guac RDP nodes | `number` | n/a | yes |
| <a name="input_cpx_instance_type"></a> [cpx\_instance\_type](#input\_cpx\_instance\_type) | The instance type for the cpx RDP nodes | `string` | n/a | yes |
| <a name="input_cpx_security_rules"></a> [cpx\_security\_rules](#input\_cpx\_security\_rules) | A map of objects of security rules to apply to the Kasm Connection Proxy server | <pre>map(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>{<br>  "https": {<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| <a name="input_default_egress"></a> [default\_egress](#input\_default\_egress) | Default egress security rule for all security groups | <pre>map(object({<br>    from_port    = number<br>    to_port      = number<br>    protocol     = string<br>    cidr_subnets = list(string)<br>  }))</pre> | <pre>{<br>  "all": {<br>    "cidr_subnets": [<br>      "0.0.0.0/0"<br>    ],<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "to_port": 0<br>  }<br>}</pre> | no |
| <a name="input_ec2_ami"></a> [ec2\_ami](#input\_ec2\_ami) | The AMI used for the EC2 nodes. Recommended Ubuntu 20.04 LTS. | `string` | n/a | yes |
| <a name="input_kasm_build"></a> [kasm\_build](#input\_kasm\_build) | The URL for the Kasm Workspaces build | `string` | n/a | yes |
| <a name="input_management_region_nat_gateway"></a> [management\_region\_nat\_gateway](#input\_management\_region\_nat\_gateway) | A list Kasm management region NAT gateways to allow Webapps ingress on 4902 to Kasm Windows agent | `string` | n/a | yes |
| <a name="input_manager_token"></a> [manager\_token](#input\_manager\_token) | The password for the database. No special characters | `string` | n/a | yes |
| <a name="input_num_agents"></a> [num\_agents](#input\_num\_agents) | The number of Agent Role Servers to create in the deployment | `number` | n/a | yes |
| <a name="input_num_cpx_nodes"></a> [num\_cpx\_nodes](#input\_num\_cpx\_nodes) | The number of cpx  Role Servers to create in the deployment | `number` | n/a | yes |
| <a name="input_num_proxy_nodes"></a> [num\_proxy\_nodes](#input\_num\_proxy\_nodes) | The number of Dedicated Proxy nodes to create in the deployment | `number` | `2` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the deployment (e.g dev, staging). A short single word | `string` | n/a | yes |
| <a name="input_proxy_hdd_size_gb"></a> [proxy\_hdd\_size\_gb](#input\_proxy\_hdd\_size\_gb) | The HDD size for Dedicated Proxy nodes | `number` | n/a | yes |
| <a name="input_proxy_instance_type"></a> [proxy\_instance\_type](#input\_proxy\_instance\_type) | The instance type for the dedicated proxy nodes | `string` | n/a | yes |
| <a name="input_proxy_security_rules"></a> [proxy\_security\_rules](#input\_proxy\_security\_rules) | A map of objects of security rules to apply to the Kasm WebApp server | <pre>map(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>{<br>  "https": {<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| <a name="input_public_lb_security_rules"></a> [public\_lb\_security\_rules](#input\_public\_lb\_security\_rules) | A map of objects of security rules to apply to the Public ALB | <pre>map(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>{<br>  "http": {<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "to_port": 80<br>  },<br>  "https": {<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| <a name="input_service_registration_token"></a> [service\_registration\_token](#input\_service\_registration\_token) | The service registration token value for cpx RDP servers to authenticate to webapps. No special characters | `string` | n/a | yes |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The amount of swap (in MB) to configure inside the compute instances | `number` | n/a | yes |
| <a name="input_web_access_cidrs"></a> [web\_access\_cidrs](#input\_web\_access\_cidrs) | List of Networks in CIDR notation for IPs allowed to access the Kasm Web interface | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_windows_security_rules"></a> [windows\_security\_rules](#input\_windows\_security\_rules) | A map of objects of security rules to apply to the Kasm Windows VMs | <pre>map(object({<br>    from_port = number<br>    to_port   = number<br>    protocol  = string<br>  }))</pre> | <pre>{<br>  "api": {<br>    "from_port": 4902,<br>    "protocol": "tcp",<br>    "to_port": 4902<br>  },<br>  "rdp": {<br>    "from_port": 3389,<br>    "protocol": "tcp",<br>    "to_port": 3389<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
