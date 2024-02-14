resource "aws_instance" "proxy" {
  count = var.num_proxy_nodes

  ami                    = var.ec2_ami
  instance_type          = var.proxy_instance_type
  vpc_security_group_ids = [aws_security_group.proxy.id]
  subnet_id              = aws_subnet.proxy[(count.index)].id
  key_name               = var.aws_key_pair
  iam_instance_profile   = var.aws_ssm_instance_profile_name

  root_block_device {
    volume_size = var.proxy_hdd_size_gb
  }

  user_data = templatefile("${path.module}/../userdata/proxy_bootstrap.sh",
    {
      kasm_build_url    = var.kasm_build
      swap_size         = var.swap_size
      manager_address   = var.aws_domain_name
      proxy_alb_address = "${var.aws_region}-proxy.${var.aws_domain_name}"
    }
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = null
  }

  tags = {
    Name = "${var.project_name}-${var.aws_region}-kasm-proxy-${count.index}"
  }
}
