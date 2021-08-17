data "template_file" "webapp_user_data" {
  template = "${file("${path.module}/userdata/webapp_bootstrap.sh")}"
  vars = {
    kasm_build_url = var.kasm_build_url
    db_ip = oci_core_instance.kasm_db_instance.private_ip
    database_password = var.database_password
    redis_password = var.redis_password
    swap_size = var.swap_size
    zone_name = "default"
  }
}

resource "oci_core_instance" "kasm_webapp_instance" {
  count               = var.num_webapps
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-Kasm-Webapp-${count.index}"
  shape               = var.instance_shape

  shape_config {
    ocpus = var.webapp_ocpus
    memory_in_gbs = var.webapp_memory_in_gb
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.kasm-webapp-subnet.id
    display_name              = "${var.project_name}-Primaryvnic"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "${var.project_name}-Kasm-Webapp-${count.index}"
  }

  source_details {
    source_type = "image"
    source_id = var.instance_image_ocid
    boot_volume_size_in_gbs = var.webapp_boot_size_gb
  }


  metadata = {
    ssh_authorized_keys = file("${var.ssh_authorized_keys}")
    user_data           = base64encode("${data.template_file.webapp_user_data.rendered}")
  }

}



