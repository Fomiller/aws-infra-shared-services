data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy" "admin_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy_document" "timestream" {
  statement {
    effect = "Allow"
    actions = [
      "timestream:*"
    ]
    resources = ["*"]
  }
}
