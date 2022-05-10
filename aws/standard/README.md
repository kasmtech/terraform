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
In the desired AWS region create an aws Key pair. This will be configured as the SSH key for the deployed EC2 machines

### AWS API Keys
Create a user via the IAM console that will be used for the terraform deployment. Give the user **Programatic Access**
and attach the existing policy **AdministratorAccess**. Save the key and key secret



# Terraform Configuration

1. Initialize the project

       terraform init

2. Open `deployment.tf` and update the variables. The variable definitions and descriptions
can be found in `module/variables.tf`
   

3. Verify the configuration

       terraform plan

4. Deploy

       terraform apply


5. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`

6. Navigate to the Agents tab, and enable each Agent after it checks in. (May take a few minutes)


