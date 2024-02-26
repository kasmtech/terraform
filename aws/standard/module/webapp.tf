resource "aws_instance" "webapp" {
  count = var.num_webapps

  ami                    = var.ec2_ami
  instance_type          = var.webapp_instance_type
  vpc_security_group_ids = [aws_security_group.webapp.id]
  subnet_id              = aws_subnet.webapp[count.index].id
  key_name               = var.aws_key_pair
  iam_instance_profile   = one(aws_iam_instance_profile.this[*].id)

  root_block_device {
    volume_size = var.webapp_hdd_size_gb
  }

  user_data = templatefile("${path.module}/userdata/webapp_bootstrap.sh",
    {
      kasm_build_url    = var.kasm_build
      db_ip             = aws_instance.db.private_ip
      database_password = var.database_password
      redis_password    = var.redis_password
      swap_size         = var.swap_size
      zone_name         = "default"
    }
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = null
  }

  tags = {
    Name = "${var.project_name}-${var.kasm_zone_name}-kasm-webapp-${count.index}"
  }
}
