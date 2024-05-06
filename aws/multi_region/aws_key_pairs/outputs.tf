output "aws_key_pair_name" {
  description = "The name of an aws keypair to use."
  value       = aws_key_pair.ssh_keys.key_name
}