resource "oci_core_instance" "kasm_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "${var.project_name}-Kasm-Workspaces"
  shape               = var.instance_shape

  shape_config {
    ocpus         = var.kasm_server_cpus
    memory_in_gbs = var.kasm_server_memory
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.kasm_subnet.id
    display_name              = "${var.project_name}-Primaryvnic"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "${var.project_name}-Kasm-Workspaces"
  }

  source_details {
    source_type             = "image"
    source_id               = var.instance_image_ocid
    boot_volume_size_in_gbs = var.kasm_server_hdd_size
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
    user_data = base64encode(templatefile("${path.module}/userdata/bootstrap.sh",
      {
        kasm_build_url = var.kasm_build_url
        user_password  = var.user_password
        admin_password = var.admin_password
        swap_size      = var.swap_size
        nginx_cert_in  = var.letsencrypt_server_type == "" ? file(var.kasm_ssl_crt_path) : acme_certificate.certificate.certificate_pem
        nginx_key_in   = var.letsencrypt_server_type == "" ? file(var.kasm_ssl_key_path) : tls_private_key.certificate_private_key.private_key_pem
      }
    ))
  }
}





