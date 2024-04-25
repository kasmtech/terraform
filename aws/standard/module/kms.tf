resource "aws_key_pair" "ssh_keys" {
  key_name   = "${var.project_name}-ssh-key"
  public_key = var.ssh_authorized_keys == "" ? tls_private_key.ssh_key[0].public_key_openssh : var.ssh_authorized_keys
}