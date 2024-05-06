data "google_compute_image" "kasm_image" {
  project = var.source_image[0].project
  family  = var.source_image[0].family
  name    = var.source_image[0].source_image
}

data "google_compute_zones" "available" {
  region = var.kasm_region
}

resource "google_compute_instance" "kasm_instance" {
  count                     = var.number_of_instances
  name                      = var.instance_details.name == "" ? substr("${var.kasm_region}-${var.instance_details.name_prefix}-0${count.index + 1}", 0, 63) : var.instance_details.name
  description               = var.instance_details.description
  machine_type              = var.instance_details.machine_type
  deletion_protection       = var.instance_details.instance_role == "agent" ? false : var.instance_delete_protection
  tags                      = var.security_tags
  labels                    = var.resource_labels
  allow_stopping_for_update = var.allow_stopping_for_update
  metadata_startup_script   = var.cloud_init_script[count.index]
  zone                      = data.google_compute_zones.available.names[count.index]

  boot_disk {
    auto_delete = var.instance_details.disk_auto_delete
    initialize_params {
      size   = var.instance_details.disk_size_gb
      type   = var.instance_details.disk_type
      image  = data.google_compute_image.kasm_image.self_link
      labels = var.resource_labels
    }
  }

  network_interface {
    network    = var.instance_network
    subnetwork = var.instance_subnetwork
    nic_type   = var.instance_nic_type
    stack_type = var.instance_nic_stack_type

    dynamic "access_config" {
      for_each = var.public_access_config
      content {
        nat_ip                 = lookup(access_config.value, "nat_ip", null)
        public_ptr_domain_name = lookup(access_config.value, "public_ptr_domain_name", null)
        network_tier           = lookup(access_config.value, "network_tier", null)
      }
    }
  }

  shielded_instance_config {
    enable_secure_boot          = var.enable_secure_boot
    enable_vtpm                 = var.enable_instance_vtpm
    enable_integrity_monitoring = var.enable_integrity_monitoring
  }

  dynamic "service_account" {
    for_each = var.service_account
    content {
      email  = lookup(service_account.value, "email", null)
      scopes = lookup(service_account.value, "scopes", null)
    }
  }

  lifecycle {
    ignore_changes = [
      metadata["ssh-keys"]
    ]
  }
}
