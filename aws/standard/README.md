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

       terraform plan -var-file settings.tfvars -var-file secrets.tfvars

4. Deploy

       terraform apply -var-file settings.tfvars -var-file secrets.tfvars

5. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`

6. Navigate to the Agents tab, and enable each Agent after it checks in. (May take a few minutes)


# AWS Terraform Variable definitions

| Variable | Description | Variable type | Example |
|:--------:|-------------|---------------|---------|
| `aws_access_key` | The AWS access key used for deployment. | String | `"AKIAJSIE27KKMHXI3BJQ"` |
| `aws_secret_key` | The AWS secret key used for deployment. | String | `"wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"` |
| `aws_region` | The AWS Region used for deployment. | String | `"us-east-1"` |
| `project_name` | The name of the deployment (e.g dev, staging). A short single word of up to 15 characters. | String | `"kasm"` |
| `aws_domain_name` | The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https. | String | `"kasm.contoso.com"` |
| `kasm_zone_name` | A name given to the kasm deployment Zone. | String | `"default"` |
| `vpc_subnet_cidr` | The subnet CIDR to use for the VPC | String | `"10.0.0.0/16"` |
| `aws_key_pair` | The name of an aws keypair to use. | String | `"kasm_ssh_key"` |
| `ec2_ami` | The AMI used for the EC2 nodes. Recommended Ubuntu 20.04 LTS. | String | `"ami-09cd747c78a9add63"` |
| `swap_size` | The amount of swap (in MB) to configure inside the Kasm servers. | Number | `2048` |
| `webapp_instance_type` | The instance type for the webapps. | String | `"t3.small"` |
| `db_instance_type` | The instance type for the webapps. | String | `"t3.medium"` |
| `agent_instance_type` | The instance type for the webapps. | String | `"t3.medium"` |
| `guac_instance_type` | The instance type for the webapps. | String | `"t3.medium"` |
| `num_webapps` | The number of WebApp role servers to create in this deployment. Acceptable ranges from 1-3. | Number | `2` |
| `num_agents` | The number of static Kasm Agents to create in this deploymenbt. Acceptable ranges from 0-100. | Number | `2` |
| `num_guac_rdp_nodes` | The number of Guacamole RDP access servers to create in this deployment. Acceptable ranges from 0-100. | Number | `1` |
| `allow_ssh_cidrs` | A list of subnets in CIDR notation allowed to SSH into your kasm servers | List(String) | `["10.0.0.0/16","172.217.22.14/32"]` |
| `web_access_cidrs` | A list of subnets in CIDR notation allowed Web access to your kasm servers | List(String) | `["0.0.0.0/0"]` |
| `database_password` | The Kasm PostgreSQL database password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `redis_password` | The Kasm Redis password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `admin_password` | The Kasm Administrative user login password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `user_password` | A Kasm standard (non-administrator) user password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `manager_token` | The manager token value used by Kasm agents to authenticate to the Kasm WebApps. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `service_registration_token` | The service registration token value used by Guac RDP servers to authenticate to the Kasm Webapps. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `kasm_build` | The download URL for the desired Kasm Workspaces version. | String | `"https://kasm-static-content.s3.amazonaws.com/kasm_release_1.13.0.002947.tar.gz"` |
| `aws_default_tags` | A Map of all tags you wish to apply to all TF created resources in this deployment. | Map(Any) | <pre align=left>{<br/>&nbsp;&nbsp;Service_name = "Kasm Workspaces"<br/>&nbsp;&nbsp;Kasm_version = "1.12"<br/>}</pre> |


# Detailed Terraform Deployment Diagram

![Detailed Diagram][Detailed_Diagram]

[Detailed_Diagram]: ./diagram/aws_multi_server.png "Detailed Diagram"