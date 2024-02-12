resource "oci_core_instance" "webapp" {
  count = var.num_webapps

  availability_domain = length(local.availability_domains) > 1 ? local.availability_domains[(count.index)].name : local.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-Kasm-Webapp-${count.index}"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.kasm_webapp_vm_settings.cpus
    memory_in_gbs = var.kasm_webapp_vm_settings.memory
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.webapp.id
    display_name              = "${var.project_name}-WebApp-Primaryvnic"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "${var.project_name}-Kasm-Webapp-${count.index}"
  }

  source_details {
    source_type             = "image"
    source_id               = var.instance_image_ocid
    boot_volume_size_in_gbs = var.kasm_webapp_vm_settings.hdd_size_gb
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
    user_data = base64encode(templatefile("${path.module}/userdata/webapp_bootstrap.sh",
      {
        kasm_build_url    = var.kasm_build_url
        db_ip             = oci_core_instance.db.private_ip
        database_password = var.database_password
        redis_password    = var.redis_password
        swap_size         = var.swap_size
        zone_name         = "default"
      }
    ))
  }

}
