resource "aws_instance" "kasm-web-app" {
  count                  = var.num_webapps
  ami                    = var.ec2_ami
  instance_type          = var.webapp_instance_type
  vpc_security_group_ids = [var.webapp_security_group_id]
  subnet_id              = var.webapp_subnet_ids[count.index]
  key_name               = var.aws_key_pair

  root_block_device {
    volume_size = var.webapp_hdd_size_gb
  }

  user_data = templatefile("${path.module}/../userdata/webapp_bootstrap.sh",
    {
      kasm_build_url    = var.kasm_build
      db_ip             = var.kasm_db_ip
      database_password = var.database_password
      redis_password    = var.redis_password
      swap_size         = var.swap_size
      zone_name         = "default"
    }
  )

  tags = {
    Name = "${var.project_name}-${var.zone_name}-kasm-webapp"
  }
}

data "aws_instance" "data-kasm_web_apps" {
  count       = var.num_webapps
  instance_id = aws_instance.kasm-web-app[count.index].id
}
