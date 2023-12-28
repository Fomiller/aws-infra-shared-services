data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy" "admin_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_user" "aws_terraform" {
  user_name = "AWSTerraform${upper(var.environment)}"
}

data "aws_iam_policy_document" "elasticache" {
  statement {
    effect = "Allow"
    actions = [
      "elasticache:*"
    ]
    resources = ["*"]
  }
}
