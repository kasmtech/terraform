resource "aws_iam_role" "this" {
  count = var.create_aws_ssm_iam_role ? 1 : 0

  name = var.aws_ssm_iam_role_name != "" ? var.aws_ssm_iam_role_name : "Kasm_SSM_IAM_Instance_Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.create_aws_ssm_iam_role ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = one(aws_iam_role.this[*].name)
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_aws_ssm_iam_role ? 1 : 0

  name = "Kasm_SSM_Instance_Profile"
  role = one(aws_iam_role.this[*].name)
}
