resource "aws_instance" "db" {
  ami                    = var.ec2_ami
  instance_type          = var.db_instance_type
  vpc_security_group_ids = [aws_security_group.db.id]
  subnet_id              = aws_subnet.db.id
  key_name               = var.aws_key_pair
  iam_instance_profile   = one(aws_iam_instance_profile.this[*].id)

  root_block_device {
    volume_size = var.db_hdd_size_gb
  }

  user_data = templatefile("${path.module}/userdata/db_bootstrap.sh",
    {
      kasm_build_url             = var.kasm_build
      user_password              = var.user_password
      admin_password             = var.admin_password
      redis_password             = var.redis_password
      database_password          = var.database_password
      service_registration_token = var.service_registration_token
      manager_token              = var.manager_token
      swap_size                  = var.swap_size
    }
  )

  tags = {
    Name = "${var.project_name}-kasm-db"
  }
}
