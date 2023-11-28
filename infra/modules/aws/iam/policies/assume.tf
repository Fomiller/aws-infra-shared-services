data "aws_iam_policy_document" "lambda" {
  statement {
    sid     = "LambdaAssumePolicy"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "eventbridge" {
  statement {
    sid     = "EventBridgeAssumePolicy"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

# data "aws_iam_policy_document" "aws_terraform_assume_policy" {
#   statement {
#     sid    = "STSassumeRole"
#     effect = "Allow"
#     actions = [
#       "sts:AssumeRole",
#       "sts:TagSession"
#     ]
#     principals {
#       type        = "AWS"
#       identifiers = [data.aws_iam_user.aws_terraform.arn]
#     }
#   }
# }
