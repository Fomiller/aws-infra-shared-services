resource "aws_kms_key" "master" {
  description             = "Fomiller master kms key"
  deletion_window_in_days = 7
}

resource "aws_kms_key_policy" "master" {
  key_id = aws_kms_key.master.id
  policy = jsonencode({
    Id = "master"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Action = "kms:*"
        Effect = "Allow"
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${title(var.namespace)}*"
        },
        Resource = "*"
      },
    ]
  })
}

resource "aws_kms_alias" "master" {
  name          = "alias/${var.namespace}-master"
  target_key_id = aws_kms_key.master.key_id
}
