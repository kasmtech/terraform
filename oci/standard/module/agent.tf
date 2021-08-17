data "template_file" "agent_user_data" {
  template = "${file("${path.module}/userdata/agent_bootstrap.sh")}"
  vars = {
    kasm_build_url    = var.kasm_build_url
    swap_size         = var.swap_size
    manager_address   = var.oci_domain_name
    manager_token     = var.manager_token
  }
}

resource "oci_core_instance" "kasm_agent_instance" {
  count               = var.num_agents
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-Kasm-Agent-${count.index}"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.agent_ocpus
    memory_in_gbs = var.agent_memory_in_gb
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.kasm-agent-subnet.id
    display_name              = "${var.project_name}-Primaryvnic"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "${var.project_name}-Kasm-Agent-${count.index}"
  }

  source_details {
    source_type               = "image"
    source_id                 = var.instance_image_ocid
    boot_volume_size_in_gbs   = var.agent_boot_size_gb
  }


  metadata = {
    ssh_authorized_keys = file("${var.ssh_authorized_keys}")
    user_data           = base64encode("${data.template_file.agent_user_data.rendered}")
  }

}

