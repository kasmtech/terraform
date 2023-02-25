resource "aws_instance" "kasm-web-app" {
  count                       = var.num_webapps
  ami                         = var.ec2_ami
  instance_type               = var.webapp_instance_type
  vpc_security_group_ids      = ["${aws_security_group.kasm-webapp-sg.id}"]
  subnet_id                   = aws_subnet.kasm-webapp-subnet.id
  key_name                    = var.aws_key_pair
  associate_public_ip_address = true

  root_block_device {
    volume_size = "40"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y jq
              set -x
              fallocate -l 4g /mnt/kasm.swap
              chmod 600 /mnt/kasm.swap
              mkswap /mnt/kasm.swap
              swapon /mnt/kasm.swap
              echo '/mnt/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab
              cd /tmp
              mkdir -p kasm_release
              wget $(curl -s ${var.kasm_build} | jq '.assets[0].browser_download_url' | sed 's/"//g')
              tar xvf kasm_*.tar.gz -C kasm_release/ --strip-components=1

              echo "Checking for Kasm DB..."
              while ! nc -vz -w 3 ${aws_instance.kasm-db.private_ip} 5432; do
                echo "Not Ready..."
                sleep 5
              done
              echo "Kasm DB is alive"

              echo "Checking for Redis DB..."
              while ! nc -vz -w 3 ${aws_instance.kasm-db.private_ip} 6379; do
                echo "Not Ready..."
                sleep 5
              done
              echo "Redis DB is alive"

              bash kasm_release/install.sh -S app -e -z ${var.zone_name} -q "${aws_instance.kasm-db.private_ip}" -Q ${var.database_password} -R ${var.redis_password}
              EOF
  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-webapp"
  }
}
