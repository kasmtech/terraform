## Connection variables
project_id                  = ""
google_credential_file_path = "./gcp_credentials.json"

## VPC and deployment environment variables
vpc_name        = ""
kasm_vpc_subnet = "10.0.0.0/16"

## Ensure the desired Database region is the first value in the list
kasm_deployment_regions = ["us-east1"] # Use only one region for Multi-Server (single-region)
#kasm_deployment_regions = ["us-west2", "asia-southeast1"]   # Use multiple regions for Multi-Region deployment

## DNS Zone settings
create_public_dns_zone    = true
public_dns_friendly_name  = "kasm-public-dns-zone"
private_dns_friendly_name = "kasm-private-dns-zone"

## Additional Kasm services or GCP features to deploy
create_kasm_autoscale_service_account = true
service_account_name                  = "kasm-autoscale"
show_passwords                        = true

## Kasm variables
kasm_domain_name  = "example.kasmweb.com"
kasm_project_name = ""
deployment_type   = "Multi-Region" # Valid values Multi-Region or Multi-Server
kasm_version      = "1.16.1"
kasm_download_url = "https://kasm-static-content.s3.amazonaws.com/kasm_release_1.16.1.6efdbd.tar.gz"

## Kasm VM instance configurations
# Webapp
webapp_vm_instance_config = {
  machine_type = "e2-standard-2"
  disk_size_gb = "50"
  disk_type    = "pd-standard"
}

# Database
database_vm_instance_config = {
  name             = "kasm-database"
  machine_type     = "e2-standard-2"
  disk_size_gb     = 50
  description      = "Kasm database with Terraform"
  disk_auto_delete = true
  disk_type        = "pd-balanced"
  instance_role    = "database"
}

# Agent
number_of_agents_per_region = 1
enable_agent_nat_gateway    = false
agent_vm_instance_config = {
  name_prefix      = "kasm-static-agent"
  machine_type     = "e2-standard-2"
  disk_size_gb     = 100
  description      = "Kasm Static agent with Terraform"
  disk_auto_delete = true
  disk_type        = "pd-balanced"
  instance_role    = "agent"
}

# Connection Proxy (Guac)
deploy_connection_proxy = false
deploy_windows_hosts    = false ## NOTE: This only creates the Windows subnet and firewall rules, it does NOT deploy Windows VMs
cpx_vm_instance_config = {
  machine_type = "e2-standard-2"
  disk_size_gb = "50"
  disk_type    = "pd-standard"
}
