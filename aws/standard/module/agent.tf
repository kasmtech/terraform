resource "aws_instance" "agent" {
  count = var.num_agents

  ami                         = var.ec2_ami
  instance_type               = var.agent_instance_type
  vpc_security_group_ids      = [aws_security_group.agent.id]
  subnet_id                   = aws_subnet.agent.id
  key_name                    = aws_key_pair.ssh_keys.key_name
  iam_instance_profile        = one(aws_iam_instance_profile.this[*].id)
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.agent_hdd_size_gb
  }

  user_data = templatefile("${path.module}/userdata/agent_bootstrap.sh",
    {
      kasm_build_url  = var.kasm_build
      swap_size       = var.swap_size
      manager_address = local.private_lb_hostname
      manager_token   = var.manager_token
    }
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = null
  }

  tags = {
    Name = "${var.project_name}-${var.kasm_zone_name}-kasm-agent-${count.index}"
  }
}
