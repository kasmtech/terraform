resource "aws_instance" "kasm-web-app" {
  count                       = "${var.num_webapps}"
  ami                         = "${var.ec2_ami}"
  instance_type               = "${var.webapp_instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.kasm-webapp-sg.id}"]
  subnet_id                   = "${var.webapp_subnet_id_1}"
  key_name                    = "${var.aws_key_pair}"

  root_block_device {
    volume_size = "40"
  }

  user_data = <<-EOF
              #!/bin/bash
              set -x
              fallocate -l 4g /mnt/kasm.swap
              chmod 600 /mnt/kasm.swap
              mkswap /mnt/kasm.swap
              swapon /mnt/kasm.swap
              echo '/mnt/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab
              cd /tmp
              wget ${var.kasm_build}
              tar xvf kasm_*.tar.gz
              echo "Checking for Kasm DB..."
              while ! nc -w 1  -z ${var.kasm_db_ip} 5432; do
                echo "Not Ready..."
                sleep 5
              done
              echo "DB is alive"

              bash kasm_release/install.sh -S app -e -z ${var.zone_name} -q ${var.kasm_db_ip} -Q ${var.database_password} -R ${var.redis_password}
              EOF
  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-webapp"
  }
}