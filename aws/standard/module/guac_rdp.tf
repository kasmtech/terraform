resource "aws_instance" "cpx" {
  count = var.num_cpx_nodes

  ami                    = var.ec2_ami
  instance_type          = var.cpx_instance_type
  vpc_security_group_ids = aws_security_group.cpx[*].id
  subnet_id              = one(aws_subnet.cpx[*].id)
  key_name               = aws_key_pair.ssh_keys.key_name
  iam_instance_profile   = one(aws_iam_instance_profile.this[*].id)

  root_block_device {
    volume_size = var.cpx_hdd_size_gb
  }

  user_data = templatefile("${path.module}/userdata/cpx_bootstrap.sh",
    {
      kasm_build_url             = var.kasm_build
      swap_size                  = var.swap_size
      manager_address            = local.private_lb_hostname
      service_registration_token = var.service_registration_token
    }
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = null
  }

  tags = {
    Name = "${var.project_name}-${var.kasm_zone_name}-kasm-cpx-${count.index}"
  }
}
