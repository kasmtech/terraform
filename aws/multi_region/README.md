# AWS Multi-Region Deploy

This project will deploy Kasm Workspaces within multiple AWS regions of your choice. Multiple [Deployment Zones](https://kasmweb.com/docs/latest/guide/zones/deployment_zones.html) will be configured for the
deployment that correspond to the desired AWS regions.

All webapp roles will be deployed in a single **"Primary"** region, with Agent roles deployed in any additional region(s).

Route53 latency policies are used to automatically connect users to webapp servers that represent their closest
Zone/Region so that session gets created in the user's closest region by default.

It is expected that administrators will configure the
[Direct to Agent](https://kasmweb.com/docs/latest/how_to/direct_to_agent.html) workflow post deployment so that session
traffic does not always traverse the **Primary Region** and instead flows directly to the Agent in whichever region it
is deployed.

![Diagram][Image_Diagram]

[Image_Diagram]: https://5856039.fs1.hubspotusercontent-na1.net/hubfs/5856039/terraform/diagrams/aws-multi-region-new.jpg "Diagram"

# Pre-Configuration

Consider creating a special sub account for the Kasm deployment.

### DNS Zone

In your AWS account create a DNS Public zone that matches the desired domain name for the deployment. e.g `kasm.contoso.com`

### SSH Key Pair

In the each AWS region where you will deploy Kasm, create an aws Key pair with the same name. The key name will be value used in the `aws_key_pair` variable and it will be configured as the SSH key for the deployed EC2 machines.

### AWS API Keys

Create a user via the IAM console that will be used for the terraform deployment. Give the user **Programatic Access** and attach the existing policy **AdministratorAccess**. Save the key and key secret.

# Terraform Configuration

1. Initialize the project

    terraform init

2. Open `terraform.tfvars` and update the variable values. The variable definitions, descriptions, and validation expectations can be found in the `variables.tf` file.

> ***NOTE:*** This document assumes you are using a separate file named `secrets.tfvars` for the AWS credentials generated in the [AWS API Keys](#aws-api-keys) section above. The .gitignore file in this repository will ignore any files named `secrets.tfvars` since they are expected to have sensitive values in them. This will prevent you from accidentally committing them to source control. If you would rather use Environment variables or some other AWS credential method in lieu of the `secrets.tfvars` file, check out the [AWS Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables) for more information about configuring your environment.

3. If you are deploying more than 2 regions, you will need to modify the `provider.tf`, `deployment.tf`, and `outputs.tf` files. There are commented sections in both files indicating how to deploy additional regions.

3. Verify the configuration

    terraform plan -var-file secrets.tfvars

4. Deploy

    terraform apply -var-file secrets.tfvars

5. Login to the Deployment as an Admin via the domain defined; e.g., `https://kasm.contoso.com`

6. Navigate to the `Infrastructure > Zones` section and update the following values according to output values from this deployment.
    - Upstream Auth Address
    - Proxy Hostname

7. Navigate to the `Infrastructure > Agents` section and enable each Agent after it checks in. (May take a few minutes)

8. Now you are ready to add Workspaces via the registry and start using Kasm!

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_primary_region"></a> [primary\_region](#module\_primary\_region) | ./primary | n/a |
| <a name="module_primary_region_webapps_and_agents"></a> [primary\_region\_webapps\_and\_agents](#module\_primary\_region\_webapps\_and\_agents) | ./webapps | n/a |
| <a name="module_region2_agents"></a> [region2\_agents](#module\_region2\_agents) | ./agents | n/a |
| <a name="module_region2_webapps"></a> [region2\_webapps](#module\_region2\_webapps) | ./webapps | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The administrative user password. No special characters | `string` | n/a | yes |
| <a name="input_agent_hdd_size_gb"></a> [agent\_hdd\_size\_gb](#input\_agent\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm Agent instances | `number` | n/a | yes |
| <a name="input_agent_instance_type"></a> [agent\_instance\_type](#input\_agent\_instance\_type) | The instance type for the Agents | `string` | n/a | yes |
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | The AWS access key used for deployment | `string` | n/a | yes |
| <a name="input_aws_default_tags"></a> [aws\_default\_tags](#input\_aws\_default\_tags) | Default tags to apply to all AWS resources for this deployment | `map(any)` | <pre>{<br>  "Kasm_version": "1.14",<br>  "Service_name": "Kasm Workspaces"<br>}</pre> | no |
| <a name="input_aws_domain_name"></a> [aws\_domain\_name](#input\_aws\_domain\_name) | The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https | `string` | n/a | yes |
| <a name="input_aws_key_pair"></a> [aws\_key\_pair](#input\_aws\_key\_pair) | The name of an aws keypair to use. | `string` | n/a | yes |
| <a name="input_aws_primary_region"></a> [aws\_primary\_region](#input\_aws\_primary\_region) | The AWS Region used for deployment | `string` | `"us-east-1"` | no |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | The AWS secret key used for deployment | `string` | n/a | yes |
| <a name="input_aws_ssm_iam_role_name"></a> [aws\_ssm\_iam\_role\_name](#input\_aws\_ssm\_iam\_role\_name) | The name of the SSM EC2 role to associate with Kasm VMs for SSH access | `string` | `""` | no |
| <a name="input_aws_ssm_instance_profile_name"></a> [aws\_ssm\_instance\_profile\_name](#input\_aws\_ssm\_instance\_profile\_name) | The name of the SSM EC2 Instance Profile to associate with Kasm VMs for SSH access | `string` | `""` | no |
| <a name="input_cpx_hdd_size_gb"></a> [cpx\_hdd\_size\_gb](#input\_cpx\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm Guac RDP instances | `number` | n/a | yes |
| <a name="input_cpx_instance_type"></a> [cpx\_instance\_type](#input\_cpx\_instance\_type) | The instance type for the Guac RDP nodes | `string` | n/a | yes |
| <a name="input_create_aws_ssm_iam_role"></a> [create\_aws\_ssm\_iam\_role](#input\_create\_aws\_ssm\_iam\_role) | Create an AWS SSM IAM role to attach to VMs for SSH/console access to VMs. | `bool` | `false` | no |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | The password for the database. No special characters | `string` | n/a | yes |
| <a name="input_db_hdd_size_gb"></a> [db\_hdd\_size\_gb](#input\_db\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm Database instances | `number` | n/a | yes |
| <a name="input_db_instance_type"></a> [db\_instance\_type](#input\_db\_instance\_type) | The instance type for the Database | `string` | n/a | yes |
| <a name="input_kasm_build"></a> [kasm\_build](#input\_kasm\_build) | Download URL for Kasm Workspaces | `string` | n/a | yes |
| <a name="input_manager_token"></a> [manager\_token](#input\_manager\_token) | The manager token value for Agents to authenticate to webapps. No special characters | `string` | n/a | yes |
| <a name="input_num_agents"></a> [num\_agents](#input\_num\_agents) | The number of Agent Role Servers to create in the deployment | `number` | `2` | no |
| <a name="input_num_cpx_nodes"></a> [num\_cpx\_nodes](#input\_num\_cpx\_nodes) | The number of RDP Conection Proxy Role Servers to create in the deployment. Set this to zero (0) and this Terraform will not deploy ANY Connection Proxy or Windows resoures like subnets, security groups, etc. | `number` | n/a | yes |
| <a name="input_num_proxy_nodes"></a> [num\_proxy\_nodes](#input\_num\_proxy\_nodes) | The number of Dedicated Proxy nodes to create in the deployment | `number` | n/a | yes |
| <a name="input_num_webapps"></a> [num\_webapps](#input\_num\_webapps) | The number of WebApp role servers to create in the deployment | `number` | `2` | no |
| <a name="input_primary_region_ec2_ami_id"></a> [primary\_region\_ec2\_ami\_id](#input\_primary\_region\_ec2\_ami\_id) | AMI Id of Kasm EC2 image in the primary region. Recommended AMI OS Version is Ubuntu 20.04 LTS. | `string` | n/a | yes |
| <a name="input_primary_vpc_subnet_cidr"></a> [primary\_vpc\_subnet\_cidr](#input\_primary\_vpc\_subnet\_cidr) | The subnet CIDR to use for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the deployment (e.g dev, staging). A short single word | `string` | n/a | yes |
| <a name="input_proxy_hdd_size_gb"></a> [proxy\_hdd\_size\_gb](#input\_proxy\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm dedicated proxy instances | `number` | n/a | yes |
| <a name="input_proxy_instance_type"></a> [proxy\_instance\_type](#input\_proxy\_instance\_type) | The instance type for the dedicated proxy node | `string` | `""` | no |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | The password for the Redis server. No special characters | `string` | n/a | yes |
| <a name="input_secondary_regions_settings"></a> [secondary\_regions\_settings](#input\_secondary\_regions\_settings) | Map of Kasm settings for secondary regions | <pre>map(object({<br>    agent_region   = string<br>    agent_vpc_cidr = string<br>    ec2_ami_id     = string<br>    })<br>  )</pre> | n/a | yes |
| <a name="input_service_registration_token"></a> [service\_registration\_token](#input\_service\_registration\_token) | The service registration token value for cpx RDP servers to authenticate to webapps. No special characters | `string` | n/a | yes |
| <a name="input_ssh_access_cidrs"></a> [ssh\_access\_cidrs](#input\_ssh\_access\_cidrs) | CIDR notation of the bastion host allowed to SSH in to the machines | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The amount of swap (in MB) to configure inside the compute instances | `number` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | The standard (non administrator) user password. No special characters | `string` | n/a | yes |
| <a name="input_web_access_cidrs"></a> [web\_access\_cidrs](#input\_web\_access\_cidrs) | CIDR notation of the bastion host allowed to SSH in to the machines | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_webapp_hdd_size_gb"></a> [webapp\_hdd\_size\_gb](#input\_webapp\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm WebApp instances | `number` | n/a | yes |
| <a name="input_webapp_instance_type"></a> [webapp\_instance\_type](#input\_webapp\_instance\_type) | The instance type for the webapps | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_region1_zone_settings"></a> [region1\_zone\_settings](#output\_region1\_zone\_settings) | Upstream Auth and Proxy settings to apply to Kasm Primary Region Zone configuration |
| <a name="output_region2_zone_settings"></a> [region2\_zone\_settings](#output\_region2\_zone\_settings) | Upstream Auth and Proxy settings to apply to Kasm Agent Region 2 Zone configuration |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Detailed Terraform Deployment Diagram

![Detailed Diagram][Detailed_Diagram]

[Detailed_Diagram]: ./diagram/aws_multi_region.png "Detailed Diagram"