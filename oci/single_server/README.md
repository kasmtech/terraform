# OCI Single Server
This project will deploy Kasm Workspaces in a single-server deployment in OCI.


![Diagram][Image_Diagram]

[Image_Diagram]: https://f.hubspotusercontent30.net/hubfs/5856039/terraform/diagrams/oci-single-server.png "Diagram"



# Pre-Configuration
Consider creating a new Compartment for the Kasm Workspaces deployment.

### DNS Zone
In OCI create a public DNS zone that matches the desired domain name for the deployment. e.g `kasm.contoso.com`.

### API Keys
Create an administative user in the OCI console that will be used for the terraform deployment. Add the user to the **Administrators** Group. Generate an API Key for the user. The API Key Fingerprint will be used as a variable in the deployment configuration. Save the private key to the local directory replacing `oci-private-key.pem`.

### SSL Certificate Options
#### Terraform-generated Let's Encrypt Certificate
To use Terraform to generate a Let's Encrypt certificate automatically, set the `letsencrypt_cert_support_email` to a valid email address and set the `letsencrypt_server_type` to either "staging" or "prod" and leave the `kasm_ssl_crt_path` and `kasm_ssl_key_path` variables empty.
***NOTE:***
- Staging generates certificates that a browser will not trust, but are formatted correctly and are designed for testing and validating the system configuraiton and deployment and has a limit of hundreds of certificates per domain per week.
- Prod generates valid Let's Encrypt certificates but is limited to 5 certificates per week per domain.

#### Bring Your Own Certificates
Create an SSL certificate that matches the desired domain for the deployment. e.g (kasm.contoso.com). Place the pem encoded cert and key in this directory overwriting  `kasm_ssl.crt` and `kasm_ssl.key`.


# Terraform Configuration
1. Initialize the project

       terraform init

2. Open `settings.tfvars` and update the variables. The variable definitions, descriptions, and validation requirements can be found in `variables.tf`, or in the [table](#oci-terraform-variable-definitions) below.
   
3. Verify the configuration

       terraform plan -var-file settings.tfvars

4. Deploy

       terraform apply -var-file settings.tfvars

5. Login to the Deployment as an Admin via the domain defined e.g `https://kasm.contoso.com`. Single server installs download all workspaces images during the install process so it may take ~15 minutes for the server to fully come online.


# OCI Terraform Variable definitions

| Variable | Description | Variable type | Example |
|:--------:|-------------|---------------|---------|
| `tenancy_ocid` | The OCI Tenancy OCID | String | `"ocid1.tenancy.oc1..aaaaaaaaai06vvcguozt39d4ilmwtpdovl998wsxpyn0hjkab2kuh7z16po7"` |
| `compartment_ocid` | The OCI Compartment OCID | String | `"ocid1.compartment.oc1..aaaaaaaauepg1z967huiazuiwjt80rtbszp64x9oxaidkoi7wz0pgr950bzb"` |
| `region` | The OCI Region name | String | `"us-ashburn-1"` |
| `user_ocid` | The OCI User OCID | String | `"ocid1.user.oc1..aaaaaaaau3me8nojmdjrbj2vzfxeouscc1i7cf9w0aoy0iyv9b38t2y0a1ba"` |
| `fingerprint` | The OCI User API Key fingerprint | String | `"66:e5:d1:85:cd:ba:ca:6a:d0:76:86:ef:1c:11:63:97"` |
| `private_key_path` | The path for the API Key PEM encoded Private Key for the OCI User. ***NOTE:*** *Ensure the API Key contents are a valid PEM encoded RSA key file. You can tell this by ensuring that the value `-----BEGIN RSA PRIVATE KEY-----` is the first line in the key file. Otherwise, you can validate the key file by running the `openssl rsa -in oci-private-key.pem -check` command.*  | String | `"./oci-private-key.pem"` |
| `project_name` | The name of the deployment (e.g dev, staging). A short single word of up to 15 characters. | String | `"kasm"` |
| `oci_domain_name` | The public Zone used for the dns entries. This must already exist in the OCI account. (e.g kasm.contoso.com). The deployment will be accessed via this zone name using https. | String | `"kasm.contoso.com"` |
| `letsencrypt_cert_support_email` | Email address to use for Terraform-generated Let's Encrypt SSL certificates | String | `"support@contoso.com"` |
| `letsencrypt_server_type` | SSL Server type for certificate generation. Valid options are staging, prod, and empty string (""). Refer to [SSL Certificate Options](#ssl-certificate-options) section of this document for more information. | String | "prod" |
| `kasm_ssl_crt_path` | Bring Your own Certificate - The file path fo the PEM encoded SSL Certificate file generated outside of Terraform. Copy/paste the contents of your generated SSL Certificate to the file designated in this path variable. | String | `"./kasm_ssl.crt"` |
| `kasm_ssl_key_path` | Bring Your own Certificate - The file path to the PEM encoded SSL Private Key file generated outside of Terraform. Copy/paste the contents of your generated SSL Private Key to the file designated in this path variable. | String | `"./kasm_ssl.key"` |
| `vcn_subnet_cidr` | The OCI VCN Subnet CIDR of the VCN where you wish to deploy Kasm | String | `"10.0.0.0/16"` |
| `ssh_authorized_keys` | The SSH Public key to be installed on the Kasm servers for SSH access | String | `"ssh-rsa some_base64_encoded_ssh_public_key_data"` |
| `instance_image_ocid` | The OCI Image OCID value of the OS to use. Kasm recommends using lates Ubuntu 20.04 LTS-Minimal for speed and efficiency. | String | `"ocid1.image.oc1.iad.aaaaaaaahiz6xym3a76xhwkmwmhrz6luyiehho7dpxpkphxhsq5q6z4m3nlq"` |
| `allow_ssh_cidrs` | A list of subnets in CIDR notation allowed to SSH into your kasm servers | List(String) | `["10.0.0.0/16","172.217.22.14/32"]` |
| `allow_web_cidrs` | A list of subnets in CIDR notation allowed Web access to your kasm servers | List(String) | `["0.0.0.0/0"]` |
| `admin_password` | The Kasm Administrative user login password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `user_password` | A Kasm standard (non-administrator) user password. String from 12-30 characters in length with no special characters. | String | `"1qaz2wsx3EDC4RFV"` |
| `kasm_build_url` | The download URL for the desired Kasm Workspaces version. | String | `"https://kasm-static-content.s3.amazonaws.com/kasm_release_1.12.0.d4fd8a.tar.gz"` |
| `swap_size` | The amount of swap (in MB) to configure inside the Kasm servers. | Number | `2048` |
| `instance_shape` | The OCI instance shape to use for Kasm deployment. Kasm recommends using a Flex instance type. | String | `"VM.Standard.E4.Flex"` |
| `kasm_server_cpus` | The number of CPUs, memory in GB, and HDD size to use for Kasm WebApps. | Number | `4` |
| `kasm_server_memory` | The number of CPUs, memory in GB, and HDD size to use for the Kasm Database server. | Number | `8` |
| `kasm_server_hdd_size` | The number of CPUs, memory in GB, and HDD size to use for the Kasm Agent server(s). | Number | `120` |


# Detailed Terraform Deployment Diagram

![Detailed Diagram][Detailed_Diagram]

[Detailed_Diagram]: ./diagram/oci_single_server.png "Detailed Diagram"
