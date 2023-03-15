resource "aws_instance" "kasm-web-app" {
  count                       = var.num_webapps
  ami                         = var.ec2_ami
  instance_type               = var.webapp_instance_type
  vpc_security_group_ids      = [data.aws_security_group.data-kasm_webapp_sg.id]
  subnet_id                   = data.aws_subnet.data-kasm_webapp_subnets[count.index].id
  key_name                    = var.aws_key_pair
  associate_public_ip_address = true

  root_block_device {
    volume_size = 40
  }

  user_data = templatefile("${path.module}/userdata/webapp_bootstrap.sh",
    {
      kasm_build_url    = var.kasm_build
      db_ip             = data.aws_instance.data-kasm_db.private_ip
      database_password = var.database_password
      redis_password    = var.redis_password
      swap_size         = var.swap_size
      zone_name         = "default"
    }
  )

  tags = {
    Name = "${var.project_name}-${var.kasm_zone_name}-kasm-webapp"
  }
}

data "aws_instance" "data-kasm_web_app" {
  count       = var.num_webapps
  instance_id = aws_instance.kasm-web-app[count.index].id
}
