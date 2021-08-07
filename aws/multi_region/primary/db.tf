resource "aws_instance" "kasm-db" {
  ami                     = "${var.ec2_ami}"
  instance_type           = "${var.db_instance_type}"
  vpc_security_group_ids  = ["${aws_security_group.kasm-default-sg.id}"]
  subnet_id               = "${aws_subnet.kasm-database-subnet.id}"
  key_name                = "${var.aws_key_pair}"

  root_block_device {
    volume_size = "40"
  }

  user_data = <<-EOF
              #!/bin/bash
              fallocate -l 4g /mnt/kasm.swap
              chmod 600 /mnt/kasmswap
              mkswap /mnt/kasm.swap
              swapon /mnt/kasm.swap
              echo '/mnt/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab
              cd /tmp
              wget ${var.kasm_build}
              tar xvf kasm_*.tar.gz
              bash kasm_release/install.sh -S db -e -Q ${var.database_password} -R ${var.redis_password} -U ${var.user_password} -P ${var.admin_password} -M ${var.manager_token}
              EOF
  tags = {
    Name = "${var.project_name}-kasm-db"
  }
}


output "kasm_db_ip" {
  value = "${aws_instance.kasm-db.private_ip}"
}

