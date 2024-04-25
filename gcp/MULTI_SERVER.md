# GCP Multi-Server Single Region
This project will deploy Kasm Workspaces in a multi-server deployment in GCP within a single region of your choice. Each Kasm server role is placed in a separate subnet and you can optionally forward traffic from user sessions on the Kasm Agent through a NAT Gateway.


![Diagram][Image_Diagram]

[Image_Diagram]: https://f.hubspotusercontent30.net/hubfs/5856039/terraform/diagrams/updated/gcp-multi-server.png "Diagram"


# Pre-Configuration
Consider creating a separate GCP Project for the Kasm deployment.

### DNS Zone
There are a couple of DNS options available with this GCP Terraform. Regardless of method, Terraform will:
  - Add a DNS record for the load balancer
  - Add a private DNS zone and add records for the private load balancer used by Agents to communicate with the webapps

  1. Create and verify the public DNS zone before deploying Terraform
    - Using this method, you will create a DNS zone or use an existing DNS zone in the same GCP Project where you deploy Kasm

  2. Allow Terraform to create the public DNS zone for you
    - Using this method, Terraform will create a public DNS zone using the values you provide, and you must manually add the name server (NS) records to the parent DNS zone so queries are forwarded correctly

### Create Terraform service account and generate an API key
Create a GCP Service Account to use with Terraform (https://cloud.google.com/iam/docs/service-accounts-create), and generate an API key. Once the API Key credential file is downloaded, copy it's contents into the `gcp_credentials.json` file in this directory, and Terraform will use these credentials to perform all operations.

Recommended Service Account roles:
- Compute Admin
- DNS Administrator
- Network Management Admin
- Service Account Admin

### GCP APIs to enable before running Terraform
There are several GCP service APIs that must be enabled before this Terraform can build successfully. In your GCP project, navigate to each of these and ensure they are enabled before running the Terraform configuration stage below.

GCP APIs:
- Cloud DNS
- Cloud NAT

# Terraform Configuration

1. Initialize the project

       terraform init

2. Open `terraform.tfvars` and update the variable values. The variable definitions, descriptions, and validation expectations can be found in the `variables.tf` file, or in the [README](./README.md).


3. Verify the configuration

       terraform plan

4. Deploy

       terraform apply

5. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`

> NOTE: The Load Balancer certificate can take between 15-45 min. to become active so you can access your Kasm deployment.

6. Navigate to the Agents tab, and enable each Agent after it checks in. (May take a few minutes)


# Detailed Terraform Deployment Diagram

![Detailed Diagram][Detailed_Diagram]

[Detailed_Diagram]: ./diagram/gcp_multi_server.png "Detailed Diagram"
