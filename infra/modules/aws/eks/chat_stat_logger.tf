data "aws_iam_policy_document" "chat_stat_logger_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values = [
        "system:serviceaccount:chat-stat:fargate-chat-stat",
      ]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

data "aws_iam_policy_document" "chat_stat_logger" {
  statement {
    effect = "Allow"
    actions = [
      "timestream:*",
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role" "chat_stat_logger" {
  assume_role_policy = data.aws_iam_policy_document.chat_stat_logger_assume_role_policy.json
  name               = "${title(var.namespace)}ChatStatLogger"
}

resource "aws_iam_policy" "chat_stat_logger" {
  policy = data.aws_iam_policy_document.chat_stat_logger.json
  name   = "${title(var.namespace)}ChatStatLoggerPolicy"
}

resource "aws_iam_role_policy_attachment" "chat_stat_logger" {
  role       = aws_iam_role.chat_stat_logger.name
  policy_arn = aws_iam_policy.chat_stat_logger.arn
}

resource "aws_iam_role_policy_attachment" "chat_stat_logger_cloudwatch" {
  role       = aws_iam_role.chat_stat_logger.name
  policy_arn = "arn:aws:iam::695434033664:policy/FomillerFargateLoggingPolicy"
}
