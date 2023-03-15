resource "aws_instance" "kasm-guac" {
  count                       = var.num_guac_nodes
  ami                         = var.ec2_ami
  instance_type               = var.guac_instance_type
  vpc_security_group_ids      = [data.aws_security_group.data-kasm_guac_sg.id]
  subnet_id                   = data.aws_subnet.data-kasm_guac_subnet.id
  key_name                    = var.aws_key_pair
  associate_public_ip_address = false

  root_block_device {
    volume_size = 120
  }

  user_data = templatefile("${path.module}/userdata/guac_bootstrap.sh",
    {
      kasm_build_url             = var.kasm_build
      swap_size                  = var.swap_size
      manager_address            = local.private_lb_hostname
      service_registration_token = var.service_registration_token
    }
  )

  tags = {
    Name = "${var.project_name}-${var.kasm_zone_name}-kasm-guac"
  }
}
