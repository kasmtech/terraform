resource "aws_instance" "kasm-agent" {
  count                  = var.num_agents
  ami                    = var.ec2_ami
  instance_type          = var.agent_instance_type
  vpc_security_group_ids = [var.agent_security_group_id]
  subnet_id              = var.agent_subnet_id
  key_name               = var.aws_key_pair

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
    Name = "${var.project_name}-${var.zone_name}-kasm-agent"
  }
}
