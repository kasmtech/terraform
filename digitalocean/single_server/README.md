# DigitalOcean Single Server
This project will deploy Kasm Workspaces in a single-server deployment on DigitalOcean.


![Diagram][Image_Diagram]

[Image_Diagram]: https://f.hubspotusercontent30.net/hubfs/5856039/terraform/diagrams/digitalocean-single-server.png "Diagram"

# Pre-Configuration

### Domain Configuration
If digitalocean is not already managing your domain you will need to have your registrar point to the DigitalOcean nameservers: https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars 

### API Tokens
Create a personal access token with read/write permissions at https://cloud.digitalocean.com/account/api/tokens 

### SSH Authorized Keys
This project will launch a droplet and allow connections using the ssh keys defined by `ssh_key_fingerprints`. You can copy the fingerprint from the desired ssh keys from https://cloud.digitalocean.com/account/security 

# Terraform Configuration

1. Initialize the project

       terraform init

2. Open `deployment.tf` and update the variables. The variable definitions and descriptions
can be found in `module/variables.tf`
   

3. Verify the configuration

       terraform plan

4. Deploy

       terraform deploy


5. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`. Single server installs
download all workspaces images during the install process so it may take ~15 minutes for the server to fully come online.
