resource "aws_key_pair" "ssh_keys" {
  key_name   = "${var.project_name}-ssh-key"
  public_key = var.ssh_authorized_keys
}