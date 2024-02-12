resource "oci_core_instance" "db" {
  availability_domain = local.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-Kasm-DB"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.kasm_database_vm_settings.cpus
    memory_in_gbs = var.kasm_database_vm_settings.memory
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.db.id
    display_name              = "${var.project_name}-DB-Primaryvnic"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "${var.project_name}-Kasm-DB"
  }

  source_details {
    source_type             = "image"
    source_id               = var.instance_image_ocid
    boot_volume_size_in_gbs = var.kasm_database_vm_settings.hdd_size_gb
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
    user_data = base64encode(templatefile("${path.module}/userdata/db_bootstrap.sh",
      {
        kasm_build_url             = var.kasm_build_url
        user_password              = var.user_password
        admin_password             = var.admin_password
        redis_password             = var.redis_password
        database_password          = var.database_password
        service_registration_token = var.service_registration_token
        manager_token              = var.manager_token
        swap_size                  = var.swap_size
      }
    ))
  }
}
