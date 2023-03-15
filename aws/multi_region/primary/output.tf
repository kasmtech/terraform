output "certificate_arn" {
  value = aws_acm_certificate_validation.kasm-elb-certificate-validation.certificate_arn
}

output "webapp_subnet_ids" {
  value = data.aws_subnet.data-kasm_webapp_subnets[*].id
}

output "agent_subnet_id" {
  value = data.aws_subnet.data-kasm_agent_subnet.id
}

output "kasm_db_ip" {
  value = data.aws_instance.data-kasm_db.private_ip
}

output "primary_vpc_id" {
  value = data.aws_vpc.data-kasm-default-vpc.id
}

output "lb_log_bucket" {
  value = data.aws_s3_bucket.data-kasm_s3_logs_bucket.bucket
}

output "lb_security_group_id" {
  value = data.aws_security_group.data-kasm_default_elb_sg.id
}

output "webapp_security_group_id" {
  value = data.aws_security_group.data-kasm_webapp_sg.id
}

output "agent_security_group_id" {
  value = data.aws_security_group.data-kasm_agent_sg.id
}
