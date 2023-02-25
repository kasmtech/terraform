resource "aws_instance" "kasm-agent" {
  count                  = var.num_agents
  ami                    = var.ec2_ami
  instance_type          = var.agent_instance_type
  vpc_security_group_ids = ["${aws_security_group.kasm-agent-sg.id}"]
  subnet_id              = aws_subnet.kasm-agent-subnet.id
  key_name               = var.aws_key_pair

  root_block_device {
    volume_size = "75"
  }

  user_data = <<-EOF
              #!/bin/bash
              fallocate -l 4g /mnt/kasm.swap
              chmod 600 /mnt/kasm.swap
              mkswap /mnt/kasm.swap
              swapon /mnt/kasm.swap
              echo '/mnt/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab
              cd /tmp
              wget ${var.kasm_build}
              tar xvf kasm_*.tar.gz
              PUBLIC_DNS=(`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`)
              bash kasm_release/install.sh --accept-eula --role agent --public-hostname $PUBLIC_DNS --manager-hostname ${var.zone_name}-lb.${var.aws_domain_name} --manager-token ${var.manager_token}               
              EOF
  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-agent"
  }
}
