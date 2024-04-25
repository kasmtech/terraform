data "google_compute_network" "network" {
  name    = var.network
  project = var.network_project == "" ? var.project : var.network_project
}

data "google_compute_subnetwork" "network" {
  name    = var.subnetwork
  project = var.network_project == "" ? var.project : var.network_project
  region  = var.region
}

resource "google_compute_forwarding_rule" "default" {
  project               = var.project
  name                  = var.name
  region                = var.region
  network               = data.google_compute_network.network.self_link
  subnetwork            = data.google_compute_subnetwork.network.self_link
  allow_global_access   = var.global_access
  load_balancing_scheme = var.load_balancing_scheme
  network_tier          = "PREMIUM"
  ip_protocol           = var.ip_protocol
  port_range            = var.port_range
  labels                = var.labels
  target                = google_compute_region_target_tcp_proxy.default.self_link
}

resource "google_compute_region_target_tcp_proxy" "default" {
  region          = var.region
  name            = "${var.name}-target-proxy"
  proxy_header    = "NONE"
  backend_service = google_compute_region_backend_service.default.self_link
}

resource "google_compute_region_backend_service" "default" {
  project                         = var.project
  name                            = "${var.name}-backend-service"
  region                          = var.region
  protocol                        = var.ip_protocol
  locality_lb_policy              = var.load_balancing_policy
  port_name                       = var.named_port
  session_affinity                = var.session_affinity
  timeout_sec                     = var.backend_timeout_sec
  load_balancing_scheme           = "INTERNAL_MANAGED"
  connection_draining_timeout_sec = var.connection_draining_timeout_sec
  dynamic "backend" {
    for_each = var.backends
    content {
      group           = lookup(backend.value, "group", null)
      description     = lookup(backend.value, "description", null)
      max_utilization = lookup(backend.value, "max_utilization", null)
      balancing_mode  = lookup(backend.value, "balancing_mode", null)
      capacity_scaler = lookup(backend.value, "capacity_scaler", null)
      failover        = lookup(backend.value, "failover", null)
    }
  }
  health_checks = [google_compute_region_health_check.tcp.self_link]
}

resource "google_compute_region_health_check" "tcp" {
  project             = var.project
  name                = "${var.name}-hc-tcp"
  region              = var.region
  timeout_sec         = var.health_check["timeout_sec"]
  check_interval_sec  = var.health_check["check_interval_sec"]
  healthy_threshold   = var.health_check["healthy_threshold"]
  unhealthy_threshold = var.health_check["unhealthy_threshold"]

  https_health_check {
    port         = var.health_check["port"]
    port_name    = var.health_check["port_name"]
    request_path = var.health_check["request_path"]
    proxy_header = var.health_check["proxy_header"]
  }

  dynamic "log_config" {
    for_each = var.health_check["enable_log"] ? [true] : []
    content {
      enable = true
    }
  }
}
