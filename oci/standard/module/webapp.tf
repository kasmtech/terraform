resource "oci_core_instance" "kasm_webapp_instance" {
  count               = var.num_webapps
  availability_domain = data.oci_identity_availability_domains.kasm_ads.availability_domains[count.index].name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-Kasm-Webapp-${count.index}"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.kasm_webapp_vm_settings.cpus
    memory_in_gbs = var.kasm_webapp_vm_settings.memory
  }

  create_vnic_details {
    subnet_id                 = data.oci_core_subnets.data-kasm_webapp_subnets[count.index].subnets[0].id
    display_name              = "${var.project_name}-Primaryvnic"
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
        db_ip             = data.oci_core_instance.data-kasm_db_instance.private_ip
        database_password = var.database_password
        redis_password    = var.redis_password
        swap_size         = var.swap_size
        zone_name         = "default"
      }
    ))
  }

}

data "oci_core_instance" "data-kasm_webapp_instances" {
  count       = var.num_webapps
  instance_id = oci_core_instance.kasm_webapp_instance[count.index].id
}
