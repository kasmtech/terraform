/* resource "aws_efs_file_system" "filesystem" {
  creation_token         = "efs"
  performance_mode       = "generalPurpose"
  throughput_mode        = "bursting"
  encrypted              = "true"
  availability_zone_name = "us-east-1b"
  tags = {
    Name = "EFS"
  }
}

resource "aws_efs_mount_target" "efs-mt" {
  file_system_id  = aws_efs_file_system.filesystem.id
  subnet_id       = aws_subnet.kasm-use-natgw-subnet.id
  security_groups = [aws_security_group.kasm-nfs-sg.id]
} */


// FSxN Configuration
resource "aws_fsx_ontap_file_system" "fsx_ontap_fs" {
  storage_capacity = 1024
  subnet_ids       = [aws_subnet.kasm-use-natgw-subnet.id]
  deployment_type  = "SINGLE_AZ_1"
  //subnet_ids          = [aws_subnet.fsxsubnet01.id, aws_subnet.fsxsubnet02.id]
  //deployment_type     = "MULTI_AZ_1"
  preferred_subnet_id = aws_subnet.kasm-use-natgw-subnet.id
  security_group_ids  = [aws_security_group.kasm-nfs-sg.id]
  throughput_capacity = 128
  fsx_admin_password  = "DefaultPass#1"

  tags = {
    "Name" = "FSxN-Demo-1"
  }
}

resource "aws_fsx_ontap_storage_virtual_machine" "fsxsvm01" {
  file_system_id             = aws_fsx_ontap_file_system.fsx_ontap_fs.id
  name                       = "svm01"
  root_volume_security_style = "MIXED"
  svm_admin_password         = "DefaultPass#1"
}

resource "aws_fsx_ontap_volume" "fsxvol01" {
  name                       = "vol1"
  junction_path              = "/vol1"
  security_style             = "MIXED"
  size_in_megabytes          = 1280000
  storage_efficiency_enabled = true
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.fsxsvm01.id

  tiering_policy {
    name           = "AUTO"
    cooling_period = 2
  }

  tags = {
    "Department" = "TestDepartment"
  }
}

