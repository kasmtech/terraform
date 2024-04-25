resource "tls_private_key" "ssh_key" {
  count     = var.ssh_authorized_keys == "" ? 1 : 0
  algorithm = "ED25519"
}

output "ssh_key_info" {
  description = "SSH Keys for use with Kasm Deployment"
  value       = <<-SSHKEYS
  SSH Keys:
  %{if var.ssh_authorized_keys == ""}
  Public Key: ${tls_private_key.ssh_key[0].public_key_openssh}
  Private Key:
  ${tls_private_key.ssh_key[0].private_key_openssh}
  %{endif}
  SSHKEYS
}