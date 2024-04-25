resource "tls_private_key" "ssh_key" {
  count     = var.ssh_authorized_keys == "" ? 1 : 0
  algorithm = "ED25519"
}
