resource "aws_instance" "agent" {
  count                       = var.num_agents
  ami                         = var.ec2_ami
  instance_type               = var.agent_instance_type
  vpc_security_group_ids      = [aws_security_group.agent.id]
  subnet_id                   = aws_subnet.agent.id
  key_name                    = var.aws_key_pair
  associate_public_ip_address = true
  iam_instance_profile        = var.aws_ssm_iam_role_name

  root_block_device {
    volume_size = var.agent_hdd_size_gb
  }

  user_data = templatefile("${path.module}/../userdata/agent_bootstrap.sh",
    {
      kasm_build_url  = var.kasm_build
      swap_size       = var.swap_size
      manager_address = var.aws_domain_name
      manager_token   = var.manager_token
    }
  )

  tags = {
    Name = "${var.project_name}-${var.aws_region}-kasm-agent-${count.index}"
  }
}
