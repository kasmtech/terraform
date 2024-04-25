/*
 * Deploy VPC and network resources
 */
## VPC
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.0"

  network_name   = var.vpc_name
  project_id     = var.project_id
  routing_mode   = "GLOBAL"
  subnets        = local.kasm_subnets
  routes         = local.kasm_routes
  firewall_rules = local.firewall_rules
  mtu            = "1500"
}

## NAT Gateway
module "cloud_nat" {
  source   = "terraform-google-modules/cloud-nat/google"
  version  = "~> 5.0"
  for_each = toset(var.kasm_deployment_regions)

  name                                = "${each.key}-nat-gateway"
  network                             = module.vpc.network_self_link
  project_id                          = var.project_id
  region                              = each.key
  create_router                       = true
  router                              = "${each.key}-router"
  enable_dynamic_port_allocation      = true
  enable_endpoint_independent_mapping = false
}

/*
 * Deploy Kasm WebApps
 */
## Create Kasm Webapp Instance Groups
module "webapp_instance_template" {
  source   = "terraform-google-modules/vm/google//modules/instance_template"
  version  = "~> 11.0"
  for_each = toset(var.kasm_deployment_regions)

  project_id           = var.project_id
  network              = local.vpc_network_self_link
  subnetwork           = "${each.key}-webapp-subnet"
  region               = each.key
  service_account      = var.compute_service_account
  name_prefix          = substr("${each.key}-${var.webapp_hostname_prefix}-template", 0, 37)
  source_image_project = var.kasm_source_image.project
  source_image_family  = var.kasm_source_image.family
  machine_type         = var.webapp_vm_instance_config.machine_type
  disk_size_gb         = var.webapp_vm_instance_config.disk_size_gb
  disk_type            = var.webapp_vm_instance_config.disk_type
  tags                 = var.kasm_firewall_security_tags.webapp
  startup_script       = local.webapp_startup_scripts[each.key]
  labels               = local.resource_labels
}

## Create Kasm Webapp Instance groups
module "webapp_instance_group" {
  source   = "terraform-google-modules/vm/google//modules/mig"
  version  = "~> 11.0"
  for_each = toset(var.kasm_deployment_regions)

  project_id                   = var.project_id
  mig_name                     = "${each.key}-${var.webapp_hostname_prefix}-group"
  instance_template            = local.webapp_instance_template_self_link[each.key]
  region                       = each.key
  hostname                     = "${each.key}-${var.webapp_hostname_prefix}"
  named_ports                  = var.webapp_named_ports
  health_check_name            = "${each.key}-${var.webapp_health_check_name}"
  health_check                 = var.webapp_health_check
  autoscaling_enabled          = true
  max_replicas                 = var.webapp_autoscale_max_instances
  min_replicas                 = var.webapp_autoscale_min_instances
  cooldown_period              = var.webapp_autoscale_cool_down_period
  autoscaling_cpu              = var.webapp_autoscale_scale_out_cpu
  autoscaling_scale_in_control = var.webapp_autoscale_scale_in_settings
}

/*
 * Deploy WebApp public and private load balancers
 */
## Internal (private) Load balancers for Agent auth
module "webapp_private_load_balancer" {
  source   = "./modules/private_load_balancer"
  for_each = toset(var.kasm_deployment_regions)

  project      = var.project_id
  region       = each.key
  network      = module.vpc.network_name
  subnetwork   = one([for subnet in module.vpc.subnets_names : subnet if can(regex("${each.key}.webapp", subnet)) ])  
  name         = "${each.key}-webapp-private-load-balancer"
  port_range   = var.webapp_named_ports[0].port
  ip_protocol  = "TCP"
  named_port   = var.webapp_named_ports[0].name
  health_check = var.webapp_health_check
  backends     = local.private_load_balancer_backends[each.key]

  depends_on = [ module.vpc ]
}

## Public access Load balancer for client Kasm access
module "public_load_balancer" {
  source  = "GoogleCloudPlatform/lb-http/google"
  version = "~> 10.0"

  name                            = var.public_load_balancer_name
  project                         = var.project_id
  https_redirect                  = true
  ssl                             = local.use_lb_ssl
  managed_ssl_certificate_domains = local.managed_ssl_domains
  certificate_map                 = local.cert_manager_map_name
  firewall_networks               = []
  firewall_projects               = []
  backends                        = local.public_load_balancer_backends
}

/*
 * Deploy Kasm Database
 */
## Database Instance
module "database_instance" {
  source               = "./modules/compute_instance"
  instance_details     = var.database_vm_instance_config
  instance_network     = local.vpc_network_self_link
  instance_subnetwork  = "${var.kasm_deployment_regions[0]}-database-subnet"
  source_image         = [var.kasm_source_image]
  service_account      = [var.compute_service_account]
  cloud_init_script    = local.database_startup_config
  security_tags        = var.kasm_firewall_security_tags.database
  resource_labels      = local.resource_labels
  public_access_config = []
  kasm_region          = var.kasm_deployment_regions[0]

  depends_on = [ module.vpc ]
}

/*
 * Deploy Kasm Agents
 */
## Agent Instances
module "agent_instances" {
  source   = "./modules/compute_instance"
  for_each = toset(var.kasm_deployment_regions)

  number_of_instances  = var.number_of_agents_per_region
  instance_details     = var.agent_vm_instance_config
  instance_network     = local.vpc_network_self_link
  instance_subnetwork  = "${each.key}-agent-subnet"
  source_image         = [var.kasm_source_image]
  service_account      = [var.compute_service_account]
  cloud_init_script    = local.agent_startup_configs[each.key]
  security_tags        = var.kasm_firewall_security_tags.agent
  resource_labels      = local.resource_labels
  public_access_config = local.agent_public_ip
  kasm_region          = each.key

  depends_on = [ module.vpc ]
}

/*
 * Deploy Kasm Connection Proxy (CPX/Guac)
 */
## Create Kasm CPX Instance templates
module "cpx_instance_template" {
  source   = "terraform-google-modules/vm/google//modules/instance_template"
  version  = "~> 11.0"
  for_each = var.deploy_connection_proxy ? toset(var.kasm_deployment_regions) : []

  project_id           = var.project_id
  network              = local.vpc_network_self_link
  subnetwork           = "${each.key}-cpx-subnet"
  region               = each.key
  service_account      = var.compute_service_account
  name_prefix          = substr("${each.key}-${var.cpx_hostname_prefix}-template", 0, 63)
  source_image_project = var.kasm_source_image.project
  source_image_family  = var.kasm_source_image.family
  machine_type         = var.cpx_vm_instance_config.machine_type
  disk_size_gb         = var.cpx_vm_instance_config.disk_size_gb
  disk_type            = var.cpx_vm_instance_config.disk_type
  tags                 = var.kasm_firewall_security_tags.webapp
  startup_script       = local.cpx_startup_configs[each.key]
  labels               = local.resource_labels

  depends_on = [ module.vpc ]
}

## Create Kasm Webapp Instance groups
module "cpx_instance_group" {
  source   = "terraform-google-modules/vm/google//modules/mig"
  version  = "~> 11.0"
  for_each = var.deploy_connection_proxy ? toset(var.kasm_deployment_regions) : []

  project_id                   = var.project_id
  mig_name                     = "${each.key}-cpx-instance-group"
  instance_template            = local.cpx_instance_template_self_link[each.key]
  region                       = each.key
  hostname                     = "${each.key}-${var.cpx_hostname_prefix}-group"
  named_ports                  = var.cpx_named_ports
  autoscaling_enabled          = true
  max_replicas                 = var.cpx_autoscale_max_instances
  min_replicas                 = var.cpx_autoscale_min_instances
  cooldown_period              = var.cpx_autoscale_cool_down_period
  autoscaling_cpu              = var.cpx_autoscale_scale_out_cpu
  autoscaling_scale_in_control = var.cpx_autoscale_scale_in_settings
}

/*
 * Deploy DNS
 */
## Public DNS Zone
module "dns_public_zone" {
  source  = "terraform-google-modules/cloud-dns/google"
  version = "~> 5.0"
  count   = var.create_public_dns_zone ? 1 : 0

  type       = "public"
  project_id = var.project_id
  name       = var.public_dns_friendly_name
  domain     = "${var.kasm_domain_name}."
  recordsets = local.public_dns_records
}

## Add records to existing public DNS zone (e.g. this TF didn't create the public zone)
module "dns_public_records" {
  source = "./modules/dns_records"
  count  = var.create_public_dns_zone ? 0 : 1

  project_id = var.project_id
  name       = var.public_dns_friendly_name
  domain     = var.kasm_domain_name
  recordsets = local.public_dns_records
}

## Private DNS Zone
module "dns_private_zone" {
  source  = "terraform-google-modules/cloud-dns/google"
  version = "~> 5.0"

  type                               = "private"
  project_id                         = var.project_id
  name                               = var.private_dns_friendly_name
  domain                             = "private.${var.kasm_domain_name}."
  private_visibility_config_networks = [local.vpc_network_self_link]
  recordsets                         = local.private_dns_records
}

/*
 * Create Kasm Autoscale service IAM account
 */
module "kasm_autoscale_service_account" {
  source = "./modules/service_account_iam"
  count  = var.create_kasm_autoscale_service_account ? 1 : 0

  project_id = var.project_id
  account_id = var.service_account_name
}

/*
 * Create passwords (always run, but not alwayse used). Refer
 * to locals.tf for conditional usage.
 */
module "passwords" {
  source       = "./modules/random"
  count        = 6
  kasm_version = var.kasm_version
}

/*
 * Create Public GCP-managed SSL cert in Cert Manager
 *
 * Using Certificate manager only works with this Terraform if you deploy it independently,
 * then reference the created certificate map ID directly. There is a concurrency issue
 * with Terraform that causes problems, so, this and the referenced module serve as an
 * example deployment method until this issue is resolved.
 */
# module "certificate_manager" {
#   source = "./modules/certificate_manager"
#   count  = var.use_gcp_certificate_manager ? 1 : 0

#   domain_name                        = var.kasm_domain_name
#   dns_managed_zone_name              = local.public_dns_name
#   certificate_name                   = local.tls_certificate_name
#   certificate_dns_authorization_name = local.tls_certificate_dns_auth_name
#   certificate_map_name               = local.tls_certificate_map_name
#   resource_labels                    = var.resource_labels
# }
