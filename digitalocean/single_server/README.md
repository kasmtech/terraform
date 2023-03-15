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

2. Open `settings.tf` and update the variables. The variable definitions and descriptions can be found in `variables.tf`.

> ***NOTE:*** This document assumes you are using a separate file named `secrets.tfvars` for the DigitalOcean token credential. The .gitignore file in this repository will ignore any files named `secrets.tfvars` since they are expected to have sensitive values in them. This will prevent you from accidentally committing them to source control. Refer to the [Generating a DigitalOcean Access Token](https://docs.digitalocean.com/reference/api/create-personal-access-token/) document if you need help with this process.

3. Verify the configuration

       terraform plan -var-file settings.tfvars -var-file secrets.tfvars

4. Deploy

       terraform apply -var-file settings.tfvars -var-file secrets.tfvars


5. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`. Single server installs download all workspaces images during the install process so it may take ~15 minutes for the server to fully come online.



# OCI Terraform Variable definitions

| Variable | Description | Variable type | Example |
|:--------:|-------------|---------------|---------|
| `digital_ocean_token` | The DigitalOcean authentication token. | String | `"dop_v1_EXAMPLEb8f85b081895f489921abbf26e64d7f3a0e581f8a1d8d532a5ba553"` |
| `digital_ocean_region` | The DigitalOcean region where you wish to deploy Kasm | String | `"nyc3"` |
| `do_domain_name` | The domain name that users will use to access kasm. | String | `"kasm.contoso.com"` |
| `ssh_key_fingerprints` | A list of DigitalOcean SSH fingerprints to use for SSH access to your Kasm server. | List(String) | `["66:e5:d1:85:cd:ba:ca:6a:d0:76:86:ef:1c:11:63:97"]` |
| `project_name` | The name of the deployment (e.g dev, staging). A short single word of up to 15 characters. | String | `"kasm"` |
| `oci_domain_name` | The public Zone used for the dns entries. This must already exist in the OCI account. (e.g kasm.contoso.com). The deployment will be accessed via this zone name using https. | String | `"kasm.contoso.com"` |
| `vpc_subnet_cidr` | The VPC Subnet CIDR where you wish to deploy Kasm | String | `"10.0.0.0/24"` |
| `digital_ocean_droplet_slug` | The Default Digital Ocean Droplet Slug: https://slugs.do-api.dev/ | String | `"s-2vcpu-4gb-intel"` |
| `digital_ocean_image` | Default Image for Ubuntu 20.04 LTS with Docker | String | `"docker-20-04"` |
| `kasm_build_url` | The download URL for the desired Kasm Workspaces version. | String | `"https://kasm-static-content.s3.amazonaws.com/kasm_release_1.12.0.d4fd8a.tar.gz"` |
| `admin_password` | The Kasm Administrative user login password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `user_password` | A Kasm standard (non-administrator) user password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `allow_ssh_cidrs` | A list of subnets in CIDR notation allowed to SSH into your kasm servers | List(String) | `["10.0.0.0/16","172.217.22.14/32"]` |
| `allow_web_cidrs` | A list of subnets in CIDR notation allowed Web access to your kasm servers | List(String) | `["0.0.0.0/0"]` |
| `swap_size` | The amount of swap (in MB) to configure inside the Kasm servers. | Number | `2048` |
| `instance_shape` | The OCI instance shape to use for Kasm deployment. Kasm recommends using a Flex instance type. | String | `"VM.Standard.E4.Flex"` |
