resource "aws_instance" "kasm-agent" {
  count                       = var.num_agents
  ami                         = var.ec2_ami
  instance_type               = var.agent_instance_type
  vpc_security_group_ids      = [data.aws_security_group.data-kasm_agent_sg.id]
  subnet_id                   = data.aws_subnet.data-kasm_agent_subnet.id
  key_name                    = var.aws_key_pair
  associate_public_ip_address = false

  root_block_device {
    volume_size = 120
  }

  user_data = templatefile("${path.module}/userdata/agent_bootstrap.sh",
    {
      kasm_build_url  = var.kasm_build
      swap_size       = var.swap_size
      manager_address = local.private_lb_hostname
      manager_token   = var.manager_token
    }
  )

  tags = {
    Name = "${var.project_name}-${var.kasm_zone_name}-kasm-agent"
  }
}
