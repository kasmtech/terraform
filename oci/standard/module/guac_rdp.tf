resource "oci_core_instance" "kasm_guac_instance" {
  count               = var.num_guac_rdp_nodes
  availability_domain = data.oci_identity_availability_domains.kasm_ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-Kasm-Guac-${count.index}"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.kasm_guac_vm_settings.cpus
    memory_in_gbs = var.kasm_guac_vm_settings.memory
  }

  create_vnic_details {
    subnet_id                 = data.oci_core_subnet.data-kasm_guac_subnet.id
    display_name              = "${var.project_name}-Primaryvnic-${count.index}"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "${var.project_name}-Kasm-Guac-${count.index}"
  }

  source_details {
    source_type             = "image"
    source_id               = var.instance_image_ocid
    boot_volume_size_in_gbs = var.kasm_guac_vm_settings.hdd_size_gb
  }


  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
    user_data = base64encode(templatefile("${path.module}/userdata/guac_bootstrap.sh",
      {
        kasm_build_url             = var.kasm_build_url
        swap_size                  = var.swap_size
        manager_address            = var.oci_domain_name
        service_registration_token = var.service_registration_token
      }
    ))
  }
}
