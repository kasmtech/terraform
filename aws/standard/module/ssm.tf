data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  count = var.create_aws_ssm_iam_role ? 1 : 0

  name               = var.aws_ssm_iam_role_name != "" ? var.aws_ssm_iam_role_name : "Kasm_SSM_IAM_Instance_Role"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.create_aws_ssm_iam_role ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = one(aws_iam_role.this[*].name)
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_aws_ssm_iam_role ? 1 : 0

  name = var.aws_ssm_instance_profile_name != "" ? var.aws_ssm_instance_profile_name : "Kasm_SSM_Instance_Profile"
  role = one(aws_iam_role.this[*].name)
}
