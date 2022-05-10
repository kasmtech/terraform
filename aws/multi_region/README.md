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
In the desired AWS region create an aws Key pair. This will be configured as the SSH key for the deployed EC2 machines

### AWS API Keys
Create a user via the IAM console that will be used for the terraform deployment. Give the user **Programatic Access**
and attach the existing policy **AdministratorAccess**. Save the key and key secret



# Terraform Configuration

1. Initialize the project

       terraform init

2. Open `variables.tf` and update the global variables. The variable definitions and descriptions
can be found in `<module-name>/variables.tf`
   
3. Open `deployment.tf` and update the module level variables as desired. 
   

4. Verify the configuration

       terraform plan

5. Deploy

       terraform apply


6. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`

7. Navigate to the Agents tab, and enable each Agent after it checks in. (May take a few minutes)

