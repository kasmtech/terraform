output "certificate_arn" {
  description = "AWS Certificate manager certificate ARN"
  value       = aws_acm_certificate_validation.this.certificate_arn
}

output "lb_subnet_ids" {
  description = "A list of the Public LB subnet IDs"
  value       = aws_subnet.alb[*].id
}

output "webapp_subnet_ids" {
  description = "A list of the Kasm Webapp subnet IDs"
  value       = aws_subnet.webapp[*].id
}

output "agent_subnet_id" {
  description = "Kasm Agent Primary region subnet ID"
  value       = aws_subnet.agent.id
}

output "cpx_subnet_id" {
  description = "Kasm cpx RDP Primary region subnet ID"
  value       = one(aws_subnet.cpx[*].id)
}

output "windows_subnet_id" {
  description = "Kasm Windows Primary region subnet ID"
  value       = one(aws_subnet.windows[*].id)
}

output "kasm_db_ip" {
  description = "Kasm Database server subnet ID"
  value       = aws_instance.db.private_ip
}

output "primary_vpc_id" {
  description = "Kasm VPC ID"
  value       = aws_vpc.this.id
}

output "lb_log_bucket" {
  description = "Load balancer logging bucket name"
  value       = aws_s3_bucket.this.bucket
}

output "lb_security_group_id" {
  description = "Kasm Load balancer security group ID"
  value       = aws_security_group.public_lb.id
}

output "webapp_security_group_id" {
  description = "Kasm Webapp security group ID"
  value       = aws_security_group.webapp.id
}

output "agent_security_group_id" {
  description = "Kasm Agent Primary region security group ID"
  value       = aws_security_group.agent.id
}

output "cpx_security_group_id" {
  description = "Kasm Connection Proxy Primary region security group ID"
  value       = one(aws_security_group.cpx[*].id)
}

output "windows_security_group_id" {
  description = "Kasm Windows Primary region security group ID"
  value       = one(aws_security_group.windows[*].id)
}

output "ssm_iam_profile" {
  description = "The SSM IAM Instance Profile name"
  value       = var.aws_ssm_iam_role_name == "" ? aws_iam_instance_profile.this[0].name : var.aws_ssm_iam_role_name
}

output "nat_gateway_ip" {
  description = "The NAT Gateway IP returned in CIDR notation for use with Windows security group rules"
  value       = "${aws_nat_gateway.this.public_ip}/32"
}
