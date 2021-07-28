resource "aws_instance" "kasm-web-app" {
  count = "${var.num_webapps}"
  ami           = "${var.ec2_ami}"
  instance_type = "${var.webapp_instance_type}"
  vpc_security_group_ids = ["${aws_security_group.kasm-webapp-sg.id}"]
  subnet_id = "${aws_subnet.kasm-webapp-subnet.id}"
  key_name = "${var.aws_key_pair}"
  associate_public_ip_address = true

  root_block_device {
    volume_size = "40"
  }

  user_data = <<-EOF
              #!/bin/bash
              fallocate -l 4g /mnt/1GiB.swap
              chmod 600 /mnt/1GiB.swap
              mkswap /mnt/1GiB.swap
              swapon /mnt/1GiB.swap
              cd /tmp
              wget ${var.kasm_build}
              tar xvf kasm_*.tar.gz
              bash kasm_release/install.sh -S app -e -z ${var.zone_name} -q "${aws_instance.kasm-db.private_ip}" -Q ${var.database_password} -R ${var.redis_password}
              EOF
  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-web-app"
  }
}
