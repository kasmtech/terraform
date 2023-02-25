resource "aws_instance" "kasm-db" {
  ami                    = var.ec2_ami
  instance_type          = var.db_instance_type
  vpc_security_group_ids = ["${aws_security_group.kasm-db-sg.id}"]
  subnet_id              = aws_subnet.kasm-db-subnet.id
  key_name               = var.aws_key_pair

  root_block_device {
    volume_size = "40"
    volume_type = "gp2"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y jq
              fallocate -l 4g /mnt/kasm.swap
              chmod 600 /mnt/kasm.swap
              mkswap /mnt/kasm.swap
              swapon /mnt/kasm.swap
              echo '/mnt/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab
              cd /tmp
              mkdir -p kasm_release
              wget $(curl -s ${var.kasm_build} | jq '.assets[0].browser_download_url' | sed 's/"//g')
              tar xvf kasm_*.tar.gz -C kasm_release/ --strip-components=1
              bash kasm_release/install.sh -S db -e -Q ${var.database_password} -R ${var.redis_password} -U ${var.user_password} -P ${var.admin_password} -M ${var.manager_token}
              EOF
  tags = {
    Name = "${var.project_name}-kasm-db"
  }
}
