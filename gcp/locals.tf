locals {
  ## GCP Credential file - set to null for users who wish to use environment/cached credentials.
  ## NOTE: If you wish to use direct-to-agent, then this credential file must be populated since
  ## Let's Encrypt will use it to automatically add the Certificate's DNS validation record.
  gcp_credentials = var.google_credential_file_path == "" ? null : file(var.google_credential_file_path)

  ## Kasm Passwords
  admin_password    = var.kasm_admin_password == "" ? module.passwords[0].password : var.kasm_admin_password
  user_password     = var.kasm_user_password == "" ? module.passwords[1].password : var.kasm_user_password
  database_password = var.kasm_database_password == "" ? module.passwords[2].password : var.kasm_database_password
  redis_password    = var.kasm_redis_password == "" ? module.passwords[3].password : var.kasm_redis_password
  service_token     = var.kasm_service_token == "" ? module.passwords[4].password : var.kasm_service_token
  manager_token     = var.kasm_manager_token == "" ? module.passwords[5].password : var.kasm_manager_token

  ## List of Kasm resources to install
  kasm_resources = compact(["webapp", "proxy", "database", "agent", var.deploy_connection_proxy ? "cpx" : "", var.deploy_windows_hosts ? "windows" : ""])

  ## Generate VPC subnet map for Kasm resources
  cidr_mask_size        = (21 - split("/", var.kasm_vpc_subnet)[1])
  vpc_subnets           = [for idx in range(pow(2, local.cidr_mask_size)) : cidrsubnet(var.kasm_vpc_subnet, local.cidr_mask_size, idx)]
  vpc_subnets_by_region = { for idx, region in var.kasm_deployment_regions : region => local.vpc_subnets[idx] }
  kasm_subnets = flatten([for r_index, region in var.kasm_deployment_regions :
    [for idx, subnet in local.kasm_resources : {
      subnet_name           = "${region}-${subnet}-subnet"
      subnet_ip             = cidrsubnet(local.vpc_subnets_by_region[region], 3, idx)
      subnet_region         = region
      subnet_private_access = subnet == "proxy" ? false : true
      purpose               = subnet == "proxy" ? "REGIONAL_MANAGED_PROXY" : "PRIVATE"
      role                  = subnet == "proxy" ? "ACTIVE" : null
    } if !(r_index != 0 && (subnet == "database"))]
  ])

  ## Create VPC routes. Use the custom_kasm_routes variable to add your own custom
  ## route entries to the VPC's route table.
  kasm_routes = concat(flatten([var.custom_kasm_routes]))

  ## VPC outputs
  vpc_network_self_link = module.vpc.network_self_link

  ## Webapp Userdata Sartup configurations
  webapp_startup_scripts = { for region in var.kasm_deployment_regions : region => templatefile("${path.module}/userdata/webapp_bootstrap.sh", {
    DB_PRIVATE_IP                  = local.database_private_ip
    KASM_DB_PASS                   = local.database_password
    KASM_REDIS_PASS                = local.redis_password
    KASM_DOWNLOAD_URL              = var.kasm_download_url
    ADDITIONAL_WEBAPP_INSTALL_ARGS = join(" ", distinct(flatten([var.additional_kasm_install_options, var.additional_webapp_install_options])))
    KASM_ZONE_NAME                 = region
  }) }

  ## Webapp instance output
  webapp_instance_template_self_link = { for region in var.kasm_deployment_regions : region => module.webapp_instance_template[region].self_link }

  ## Database Userdata Startup configuration
  database_startup_config = [templatefile("${path.module}/userdata/database_bootstrap.sh", {
    KASM_USER_PASS                   = local.user_password
    KASM_ADMIN_PASS                  = local.admin_password
    KASM_MANAGER_TOKEN               = local.manager_token
    KASM_SERVICE_TOKEN               = local.service_token
    KASM_DB_PASS                     = local.database_password
    KASM_REDIS_PASS                  = local.redis_password
    KASM_DOWNLOAD_URL                = var.kasm_download_url
    ADDITIONAL_DATABASE_INSTALL_ARGS = join(" ", distinct(flatten([var.additional_kasm_install_options, var.additional_database_install_options])))
  })]

  ## Database outputs
  database_private_ip = module.database_instance.private_ip[0]

  ## Agent Userdata Startup configurations
  agent_public_ip = var.enable_agent_nat_gateway ? [] : [{ network_tier = "PREMIUM" }]
  agent_startup_configs = { for region in var.kasm_deployment_regions : region => [
    for idx in range(var.number_of_agents_per_region) : templatefile("${path.module}/userdata/agent_bootstrap.sh", {
      KASM_MANAGER_TOKEN            = local.manager_token
      PRIVATE_LB_HOSTNAME           = "${region}-lb.private.${var.kasm_domain_name}"
      KASM_DOWNLOAD_URL             = var.kasm_download_url
      ADDITIONAL_AGENT_INSTALL_ARGS = join(" ", distinct(flatten([var.additional_kasm_install_options, var.additional_agent_install_options])))
      GPU_ENABLED                   = var.agent_gpu_enabled ? "1" : "0"
    })]
  }

  ## CPX Userdata Sartup configurations
  cpx_startup_configs = { for region in var.kasm_deployment_regions : region => templatefile("${path.module}/userdata/cpx_bootstrap.sh", {
    PRIVATE_LB_HOSTNAME         = "${region}-lb.private.${var.kasm_domain_name}"
    KASM_SERVICE_TOKEN          = local.service_token
    KASM_DOWNLOAD_URL           = var.kasm_download_url
    ADDITIONAL_CPX_INSTALL_ARGS = join(" ", distinct(flatten([var.additional_kasm_install_options, var.additional_cpx_install_options])))
    KASM_ZONE_NAME              = region
  }) }

  ## CPX Outputs
  cpx_instance_template_self_link = var.deploy_connection_proxy ? { for region in var.kasm_deployment_regions : region => module.cpx_instance_template[region].self_link } : {}

  ## Public load balancer backends
  public_load_balancer_backends = {
    kasm-global-lb-backend = {
      description                     = "Global HTTPS Load balancer backend"
      protocol                        = "HTTPS"
      port                            = var.webapp_named_ports[0].port
      port_name                       = var.webapp_named_ports[0].name
      timeout_sec                     = 1800
      enable_cdn                      = false
      health_check                    = var.webapp_lb_health_check
      custom_request_headers          = []
      custom_response_headers         = []
      compression_mode                = ""
      affinity_cookie_ttl_sec         = null
      connection_draining_timeout_sec = null
      edge_security_policy            = null
      security_policy                 = null
      session_affinity                = null
      log_config = {
        enable      = false
        sample_rate = null
      }
      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
      groups = [for region in var.kasm_deployment_regions :
        {
          group                        = module.webapp_instance_group[region].instance_group
          max_utilization              = 0.8
          description                  = "${region} Webapp Public LB Backend"
          balancing_mode               = "UTILIZATION"
          max_connections              = null
          max_connections_per_endpoint = null
          max_connections_per_instance = null
          max_rate                     = null
          max_rate_per_endpoint        = null
          max_rate_per_instance        = null
          capacity_scaler              = null
        }
      ]
    }
  }

  private_load_balancer_backends = { for region in var.kasm_deployment_regions : region => [
    {
      group           = module.webapp_instance_group[region].instance_group
      max_utilization = 0.8
      description     = "${title(region)} Webapp private load balancer backend"
      balancing_mode  = "UTILIZATION"
      failover        = false
      capacity_scaler = 1
    }]
  }

  ## TLS Certificate locals for public Load Balancer
  managed_ssl_domains   = var.use_gcp_certificate_manager ? [] : [var.kasm_domain_name]
  use_lb_ssl            = var.use_gcp_certificate_manager ? false : true
  cert_manager_map_name = null #var.use_gcp_certificate_manager ? "" : "" #module.certificate_manager[0].certificate_map_id : ""

  public_dns_records = [{
    name = ""
    type = "A"
    ttl  = 300
    records = [
      module.public_load_balancer.external_ip
    ]
  }]

  ## Private DNS Load balancer records
  private_dns_records = [for region in var.kasm_deployment_regions : {
    name    = "${region}-lb"
    type    = "A"
    ttl     = 300
    records = [module.webapp_private_load_balancer[region].ip_address]
  }]

  ## VPC Firewall rules
  firewall_rules = concat(flatten([[for rule in [
    {
      name        = "kasm-webapp"
      description = "Webapp HTTPS ingress"
      priority    = 1000
      direction   = "INGRESS"
      ranges      = ["130.211.0.0/22", "35.191.0.0/16"]
      source_tags = compact(flatten([
        var.kasm_firewall_security_tags.agent,
        var.deploy_connection_proxy ? var.kasm_firewall_security_tags.cpx : []
      ]))
      target_tags = var.kasm_firewall_security_tags.webapp
      allow = [{
        protocol = "tcp"
        ports    = ["443"]
      }]
    },
    {
      name        = "kasm-agent"
      description = "Kasm Agent ingress"
      priority    = 1010
      direction   = "INGRESS"
      source_tags = var.kasm_firewall_security_tags.webapp
      target_tags = var.kasm_firewall_security_tags.agent
      allow = [{
        protocol = "tcp"
        ports    = ["443"]
      }]
    },
    {
      name        = "kasm-agent-to-private-lb"
      description = "Private Load Balancer ingress from agent to webapp"
      priority    = 1020
      direction   = "INGRESS"
      target_tags = var.kasm_firewall_security_tags.webapp
      ranges      = [for dict in local.kasm_subnets : dict.subnet_ip if contains(split("-", dict.subnet_name), "proxy")]
      allow = [{
        protocol = "tcp"
        ports    = ["443"]
      }]
    },
    {
      name        = "kasm-database"
      description = "Kasm Database ingress"
      priority    = 1030
      direction   = "INGRESS"
      source_tags = var.kasm_firewall_security_tags.webapp
      target_tags = var.kasm_firewall_security_tags.database
      ranges      = ["35.235.240.0/20"]
      allow = [{
        protocol = "tcp"
        ports    = ["5432", "6379"]
      }]
    },
    {
      name        = "ssh-access"
      description = "Allow GCP web-based SSH access to Kasm services"
      prioritiy   = 1040
      direction   = "INGRESS"
      ranges      = ["35.235.240.0/20"]
      target_tags = compact(flatten([
        var.kasm_firewall_security_tags.webapp,
        var.kasm_firewall_security_tags.agent,
        var.kasm_firewall_security_tags.database,
        var.deploy_connection_proxy ? var.kasm_firewall_security_tags.cpx : []
      ]))
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
    },
    var.deploy_connection_proxy ? {
      name        = "connection-proxy"
      description = "Kasm Connection Proxy ingress"
      priority    = 1050
      direction   = "INGRESS"
      source_tags = var.kasm_firewall_security_tags.webapp
      target_tags = var.kasm_firewall_security_tags.cpx
      ranges      = ["35.235.240.0/20"]
      allow = [{
        protocol = "tcp"
        ports    = ["443"]
      }]
    } : null,
    var.deploy_windows_hosts ? {
      name        = "windows-hosts"
      description = "Kasm Windows-managed Host ingress"
      priority    = 1060
      direction   = "INGRESS"
      source_tags = flatten([
        var.kasm_firewall_security_tags.cpx,
        var.kasm_firewall_security_tags.webapp
      ])
      target_tags = var.kasm_firewall_security_tags.windows
      allow = [{
        protocol = "tcp"
        ports    = ["3389", "4902"]
      }]
    } : null
  ] : rule if rule != null], var.custom_firewall_rules]))

  ## Labels to apply to resources
  resource_labels = merge(var.resource_labels, {
    deployed_by          = "terraform"
    deployed_application = "kasm_workspaces"
    customer             = "weave"
    kasm_version         = try(replace("v${var.kasm_version}", ".", "-"), null)
    project_name         = try(lower(var.kasm_project_name), null)
    deployment_type      = try(lower(var.deployment_type), null)
  })
}
