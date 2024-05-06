resource "oci_core_instance" "cpx" {
  count = var.num_cpx_nodes

  availability_domain = length(local.availability_domains) > 1 ? local.availability_domains[(count.index)].name : local.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-Kasm-cpx-${count.index}"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.kasm_cpx_vm_settings.cpus
    memory_in_gbs = var.kasm_cpx_vm_settings.memory
  }

  create_vnic_details {
    subnet_id                 = one(oci_core_subnet.cpx[*].id)
    display_name              = "${var.project_name}-CPX-Primaryvnic-${count.index}"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "${var.project_name}-Kasm-cpx-${count.index}"
  }

  source_details {
    source_type             = "image"
    source_id               = var.instance_image_ocid
    boot_volume_size_in_gbs = var.kasm_cpx_vm_settings.hdd_size_gb
  }


  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys == "" ? tls_private_key.ssh_key[0].public_key_openssh : var.ssh_authorized_keys
    user_data = base64encode(templatefile("${path.module}/userdata/cpx_bootstrap.sh",
      {
        kasm_build_url             = var.kasm_build_url
        swap_size                  = var.swap_size
        manager_address            = var.oci_domain_name
        service_registration_token = var.service_registration_token
      }
    ))
  }
}
