resource "oci_core_instance" "bastion" {
  availability_domain = local.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-Kasm-SSH-Bastion"
  shape               = var.instance_shape

  shape_config {
    baseline_ocpu_utilization = var.bastion_vm_utilization
    ocpus                     = var.bastion_vm_settings.cpus
    memory_in_gbs             = var.bastion_vm_settings.memory
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.lb.id
    display_name              = "${var.project_name}-Bastion-Primaryvnic"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "${var.project_name}-Kasm-Bastion"
  }

  source_details {
    source_type             = "image"
    source_id               = var.instance_image_ocid
    boot_volume_size_in_gbs = var.bastion_vm_settings.hdd_size_gb
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys == "" ? tls_private_key.ssh_key[0].public_key_openssh : var.ssh_authorized_keys
  }
}
