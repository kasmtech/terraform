resource "aws_instance" "kasm-agent" {
  depends_on = [
    aws_fsx_ontap_storage_virtual_machine.fsxsvm01,
    aws_fsx_ontap_volume.fsxvol01
  ]
  count                       = var.num_agents
  ami                         = var.ec2_ami
  instance_type               = var.agent_instance_type
  vpc_security_group_ids      = ["${aws_security_group.kasm-agent-sg.id}", "${aws_security_group.kasm-nfs-sg.id}"]
  subnet_id                   = aws_subnet.kasm-use-natgw-subnet.id
  key_name                    = var.aws_key_pair
  associate_public_ip_address = false

  root_block_device {
    volume_size = "75"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update
              echo nameserver 169.254.169.253 | sudo tee /etc/resolv.conf
              service network-manager restart
              apt install -y nfs-common jq
              fallocate -l 5g /mnt/kasm.swap
              chmod 600 /mnt/kasm.swap
              mkswap /mnt/kasm.swap
              swapon /mnt/kasm.swap
              echo '/mnt/kasm.swap swap swap defaults 0 0' | tee -a /etc/fstab
              mkdir -p /mnt/kasm_shared
              echo '${aws_fsx_ontap_storage_virtual_machine.fsxsvm01.id}.${aws_fsx_ontap_file_system.fsx_ontap_fs.id}.fsx.${var.aws_region}.amazonaws.com:/${aws_fsx_ontap_volume.fsxvol01.junction_path} /mnt/kasm_shared nfs defaults 0 0' | tee -a /etc/fstab
              mount -a
              mkdir -p /mnt/kasm_shared/profiles
              cd /tmp
              mkdir -p kasm_release
              wget $(curl -s ${var.kasm_build} | jq '.assets[0].browser_download_url' | sed 's/"//g')
              tar xvf kasm_*.tar.gz -C kasm_release/ --strip-components=1

              echo "Checking for Kasm DB..."
              while ! nc -w 1  -z ${aws_instance.kasm-db.private_ip} 5432; do
                echo "Not Ready..."
                sleep 5
              done
              echo "DB is alive"

              echo "Checking for Kasm Web App..."
              while ! nc -w 1  -z ${var.zone_name}-lb.${var.aws_domain_name} 443; do
                echo "Not Ready..."
                sleep 5
              done
              echo "DB is alive"

              PRIVATE_IP=(`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`)
              bash kasm_release/install.sh --accept-eula --role agent --public-hostname $PRIVATE_IP --manager-hostname ${var.zone_name}-lb.${var.aws_domain_name} --manager-token ${var.manager_token}
              EOF
  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-agent"
  }
}

// bash kasm_release/install.sh --role agent --public-hostname $PRIVATE_IP --manager-hostname default-lb.kasm.trackeroid.space --manager-token changeme
