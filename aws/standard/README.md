# AWS Multi-Server Single Region
This project will deploy Kasm Workspaces in a multi-server deployment in AWS within a single region of your choice.
Each role is placed in a separate subnet and traffic from user sessions on the Agent egresses out of a Nat Gateway.


![Diagram][Image_Diagram]

[Image_Diagram]: https://f.hubspotusercontent30.net/hubfs/5856039/terraform/diagrams/aws-multi-server-nat-gw.png "Diagram"


# Pre-Configuration
Consider creating a special sub account for the Kasm deployment.

### DNS Zone
In your AWS account create a DNS Public zone that matches the desired domain name for the deployment. e.g `kasm.contoso.com`

### SSH Key Pair
In the desired AWS region create an aws Key pair. The key name will be value used in the `aws_key_pair` variable and it will be configured as the SSH key for the deployed EC2 machines.

### AWS API Keys
Create a user via the IAM console that will be used for the terraform deployment. Give the user **Programatic Access** and attach the existing policy **AdministratorAccess**. Save the key and key secret


# Terraform Configuration

1. Initialize the project

       terraform init

2. Open `settings.tfvars` and update the variable values. The variable definitions, descriptions, and validation expectations can be found in the `variables.tf` file.

> ***NOTE:*** This document assumes you are using a separate file named `secrets.tfvars` for the AWS credentials generated in the [AWS API Keys](#aws-api-keys) section above. The .gitignore file in this repository will ignore any files named `secrets.tfvars` since they are expected to have sensitive values in them. This will prevent you from accidentally committing them to source control.

3. Verify the configuration

       terraform plan -var-file secrets.tfvars

4. Deploy

       terraform apply -var-file settings.tfvars -var-file secrets.tfvars

5. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`

6. Navigate to the Agents tab, and enable each Agent after it checks in. (May take a few minutes)

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
| <a name="module_standard"></a> [standard](#module\_standard) | ./module | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The administrative user password. No special characters | `string` | n/a | yes |
| <a name="input_agent_hdd_size_gb"></a> [agent\_hdd\_size\_gb](#input\_agent\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm Agent instances | `number` | n/a | yes |
| <a name="input_agent_instance_type"></a> [agent\_instance\_type](#input\_agent\_instance\_type) | The instance type for the Agents | `string` | n/a | yes |
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | The AWS access key used for deployment | `string` | n/a | yes |
| <a name="input_aws_default_tags"></a> [aws\_default\_tags](#input\_aws\_default\_tags) | Default tags to apply to all AWS resources for this deployment | `map(any)` | `{}` | no |
| <a name="input_aws_domain_name"></a> [aws\_domain\_name](#input\_aws\_domain\_name) | The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https | `string` | n/a | yes |
| <a name="input_aws_key_pair"></a> [aws\_key\_pair](#input\_aws\_key\_pair) | The name of an aws keypair to use. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS Region used for deployment | `string` | `"us-east-1"` | no |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | The AWS secret key used for deployment | `string` | n/a | yes |
| <a name="input_aws_ssm_iam_role_name"></a> [aws\_ssm\_iam\_role\_name](#input\_aws\_ssm\_iam\_role\_name) | The name of the SSM EC2 role to associate with Kasm VMs for SSH access | `string` | `""` | no |
| <a name="input_cpx_hdd_size_gb"></a> [cpx\_hdd\_size\_gb](#input\_cpx\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm cpx RDP instances | `number` | n/a | yes |
| <a name="input_cpx_instance_type"></a> [cpx\_instance\_type](#input\_cpx\_instance\_type) | The instance type for the cpxamole RDP nodes | `string` | n/a | yes |
| <a name="input_create_aws_ssm_iam_role"></a> [create\_aws\_ssm\_iam\_role](#input\_create\_aws\_ssm\_iam\_role) | Create an AWS SSM IAM role to attach to VMs for SSH/console access to VMs. | `bool` | `false` | no |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | The password for the database. No special characters | `string` | n/a | yes |
| <a name="input_db_hdd_size_gb"></a> [db\_hdd\_size\_gb](#input\_db\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm Database instances | `number` | n/a | yes |
| <a name="input_db_instance_type"></a> [db\_instance\_type](#input\_db\_instance\_type) | The instance type for the Database | `string` | n/a | yes |
| <a name="input_ec2_ami_id"></a> [ec2\_ami\_id](#input\_ec2\_ami\_id) | The AMI used for the EC2 nodes. Recommended Ubuntu 22.04 LTS. | `string` | n/a | yes |
| <a name="input_kasm_build"></a> [kasm\_build](#input\_kasm\_build) | The URL for the Kasm Workspaces build | `string` | n/a | yes |
| <a name="input_kasm_zone_name"></a> [kasm\_zone\_name](#input\_kasm\_zone\_name) | A name given to the kasm deployment Zone | `string` | `"default"` | no |
| <a name="input_manager_token"></a> [manager\_token](#input\_manager\_token) | The manager token value for Agents to authenticate to webapps. No special characters | `string` | n/a | yes |
| <a name="input_num_agents"></a> [num\_agents](#input\_num\_agents) | The number of Agent Role Servers to create in the deployment | `number` | n/a | yes |
| <a name="input_num_cpx_nodes"></a> [num\_cpx\_nodes](#input\_num\_cpx\_nodes) | The number of Agent Role Servers to create in the deployment | `number` | n/a | yes |
| <a name="input_num_webapps"></a> [num\_webapps](#input\_num\_webapps) | The number of WebApp role servers to create in the deployment | `number` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of the deployment (e.g dev, staging). A short single word | `string` | n/a | yes |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | The password for the Redis server. No special characters | `string` | n/a | yes |
| <a name="input_service_registration_token"></a> [service\_registration\_token](#input\_service\_registration\_token) | The service registration token value for cpx RDP servers to authenticate to webapps. No special characters | `string` | n/a | yes |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | The amount of swap (in MB) to configure inside the compute instances | `number` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | The standard (non administrator) user password. No special characters | `string` | n/a | yes |
| <a name="input_vpc_subnet_cidr"></a> [vpc\_subnet\_cidr](#input\_vpc\_subnet\_cidr) | The subnet CIDR to use for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_web_access_cidrs"></a> [web\_access\_cidrs](#input\_web\_access\_cidrs) | CIDR notation of the bastion host allowed to SSH in to the machines | `list(string)` | n/a | yes |
| <a name="input_webapp_hdd_size_gb"></a> [webapp\_hdd\_size\_gb](#input\_webapp\_hdd\_size\_gb) | The HDD size in GB to configure for the Kasm WebApp instances | `number` | n/a | yes |
| <a name="input_webapp_instance_type"></a> [webapp\_instance\_type](#input\_webapp\_instance\_type) | The instance type for the webapps | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kasm_zone_settings"></a> [kasm\_zone\_settings](#output\_kasm\_zone\_settings) | Upstream Auth settings to apply to Kasm Zone configuration |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Detailed Terraform Deployment Diagram

![Detailed Diagram][Detailed_Diagram]

[Detailed_Diagram]: ./diagram/aws_multi_server.png "Detailed Diagram"