resource "aws_iam_role" "this" {
  count = var.aws_ssm_iam_role_name == "" ? 1 : 0

  name = "Kasm_SSM_IAM_Instance_Role"
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
  count = var.aws_ssm_iam_role_name == "" ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.this[0].name
}

resource "aws_iam_instance_profile" "this" {
  count = var.aws_ssm_iam_role_name == "" ? 1 : 0

  name = "Kasm_SSM_Instance_Profile"
  role = aws_iam_role.this[0].name
}
