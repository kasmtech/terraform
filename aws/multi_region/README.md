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

[Image_Diagram]: https://f.hubspotusercontent30.net/hubfs/5856039/terraform/diagrams/aws-multi-region-int-gw.png "Diagram"


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

2. Open `settings.tfvars` and update the variable values. The variable definitions, descriptions, and validation expectations can be found in the `variables.tf` file.

> ***NOTE:*** This document assumes you are using a separate file named `secrets.tfvars` for the AWS credentials generated in the [AWS API Keys](#aws-api-keys) section above. The .gitignore file in this repository will ignore any files named `secrets.tfvars` since they are expected to have sensitive values in them. This will prevent you from accidentally committing them to source control.

3. If you are deploying more than 2 regions, you will need to modify the `provider.tf` and the `deployment.tf` files. There are commented sections in both files indicating how to deploy additional regions.

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
| `aws_primary_region` | The AWS Region to deploy all Kasm Management resources. | String | `"us-east-1"` |
| `project_name` | The name of the deployment (e.g dev, staging). A short single word of up to 15 characters. | String | `"kasm"` |
| `aws_domain_name` | The Route53 Zone used for the dns entries. This must already exist in the AWS account. (e.g dev.kasm.contoso.com). The deployment will be accessed via this zone name via https. | String | `"kasm.contoso.com"` |
| `kasm_zone_name` | A name given to the kasm deployment Zone. | String | `"default"` |
| `primary_vpc_subnet_cidr` | The subnet CIDR to use for the Primary region's VPC. | String | `"10.0.0.0/16"` |
| `aws_key_pair` | The name of an aws keypair to use. | String | `"kasm_ssh_key"` |
| `primary_region_ec2_ami_id` | The AMI used for the EC2 nodes in the Primary (Management) region. Recommended Ubuntu 20.04 LTS. | String | `"ami-09cd747c78a9add63"` |
| `swap_size` | The amount of swap (in MB) to configure inside the Kasm servers. | Number | `2048` |
| `webapp_instance_type` | The instance type for the Kasm WebApps. | String | `"t3.small"` |
| `webapp_hdd_size_gb` | The HDD size for the WebApp EC2s in GB. | Number | `40` |
| `db_instance_type` | The instance type for the Kasm Database. | String | `"t3.medium"` |
| `db_hdd_size_gb` | The HDD size for the DB EC2 in GB. | Number | `40` |
| `agent_instance_type` | The instance type for the Kasm Agents in the Primary region. | String | `"t3.medium"` |
| `agent_hdd_size_gb` | The HDD size for the Agent EC2s in GB. | Number | `120` |
| `num_webapps` | The number of WebApp role servers to create in this deployment. Acceptable ranges from 1-3. | Number | `2` |
| `num_agents` | The number of static Kasm Agents to create in the primary region. Acceptable ranges from 0-100. | Number | `2` |
| `allow_ssh_cidrs` | A list of subnets in CIDR notation allowed to SSH into your kasm servers (use `["0.0.0.0/0]"` to allow SSH from any IP). | List(String) | `["1.1.1.1/32","172.217.22.14/32"]` |
| `web_access_cidrs` | A list of subnets in CIDR notation allowed Web access to your kasm servers (use `["0.0.0.0/0]"` to allow HTTP/HTTPS from any IP). | List(String) | `["0.0.0.0/0"]` |
| `secondary_regions_settings` | A map of AWS environment settings for secondary regions. The Primary region is considered "region1", thus all secondary regions should be labeled "region2", "region3", etc. Refer to the commented settings in the `secondary_regions_settings` variable in the `settings.tf` for an example. | Map(any) | <pre>{<br/>&nbsp;&nbsp;region2 = {<br/>&nbsp;&nbsp;&nbsp;&nbsp;agent_region = "eu-central-1"<br/>&nbsp;&nbsp;&nbsp;&nbsp;agent_ec2_ami_id = "ami-0e067cc8a2b58de59"<br/>&nbsp;&nbsp;&nbsp;&nbsp;agent_instance_type = "t3.medium"<br/>&nbsp;&nbsp;&nbsp;&nbsp;num_agents = 2<br/>&nbsp;&nbsp;&nbsp;&nbsp;agent_vpc_cidr = "10.1.0.0/16"<br/>&nbsp;&nbsp;}<br/>}</pre>
| `database_password` | The Kasm PostgreSQL database password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `redis_password` | The Kasm Redis password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `admin_password` | The Kasm Administrative user login password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `user_password` | A Kasm standard (non-administrator) user password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `manager_token` | The manager token value used by Kasm agents to authenticate to the Kasm WebApps. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `kasm_build` | The download URL for the desired Kasm Workspaces version. | String | `"https://kasm-static-content.s3.amazonaws.com/kasm_release_1.12.0.d4fd8a.tar.gz"` |
| `aws_default_tags` | A Map of all tags you wish to apply to all TF created resources in this deployment. | Map(Any) | <pre>{<br/>&nbsp;&nbsp;Service_name = "Kasm Workspaces"<br/>&nbsp;&nbsp;Kasm_version = "1.12"<br/>}</pre> |


# Detailed Terraform Deployment Diagram

![Detailed Diagram][Detailed_Diagram]

[Detailed_Diagram]: ./diagram/aws_multi_region.png "Detailed Diagram"