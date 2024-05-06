resource "random_password" "password" {
  keepers = {
    kasm_version = var.kasm_version
  }

  length  = 30
  special = false
}
