data "aws_elb_service_account" "main" {}

resource "aws_s3_bucket" "kasm_s3_logs" {
  bucket_prefix = "${var.project_name}-${var.zone_name}-"
  force_destroy = true
}

data "aws_s3_bucket" "data-kasm_s3_logs_bucket" {
  bucket = aws_s3_bucket.kasm_s3_logs.bucket
}

resource "aws_s3_bucket_acl" "kasm_s3_acl" {
  bucket = data.aws_s3_bucket.data-kasm_s3_logs_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "kasm_s3_logs_policy" {
  bucket = data.aws_s3_bucket.data-kasm_s3_logs_bucket.id

  policy = jsonencode({
    Id      = "Policy"
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.kasm_s3_logs.arn}/AWSLogs/*"
        Principal = {
          AWS = [
            data.aws_elb_service_account.main.arn
          ]
        }
      }
    ]
  })
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt_elb_bucket" {
  bucket = data.aws_s3_bucket.data-kasm_s3_logs_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_log_public_access" {
  bucket                  = data.aws_s3_bucket.data-kasm_s3_logs_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
