data "template_file" "db_user_data" {
  template = "${file("${path.module}/userdata/db_bootstrap.sh")}"
  vars = {
    kasm_build_url      = var.kasm_build_url
    user_password       = var.user_password
    admin_password      = var.admin_password
    redis_password      = var.redis_password
    database_password   = var.database_password
    manager_token       = var.manager_token
    swap_size           = var.swap_size

  }
}

resource "oci_core_instance" "kasm_db_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-Kasm-DB"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.db_ocpus
    memory_in_gbs = var.db_memory_in_gb
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.kasm-db-subnet.id
    display_name              = "${var.project_name}-Primaryvnic"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "${var.project_name}-Kasm-DB"
  }

  source_details {
    source_type             = "image"
    source_id               = var.instance_image_ocid
    boot_volume_size_in_gbs = var.db_boot_size_gb
  }


  metadata = {
    ssh_authorized_keys = file("${var.ssh_authorized_keys}")
    user_data           = base64encode("${data.template_file.db_user_data.rendered}")
  }

}


