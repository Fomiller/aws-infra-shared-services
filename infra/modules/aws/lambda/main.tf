resource "aws_lambda_function" "lambda" {
  function_name    = "fomiller-congocoon-scraper"
  role             = aws_iam_role.lambda_role.arn
  filename         = "${path.module}/lambda_function.zip"
  handler          = "lambda-go"
  source_code_hash = data.archive_file.zip.output_base64sha256
  runtime          = "go1.x"
  memory_size      = 128
  timeout          = 10

}

resource "aws_iam_role" "lambda_role" {
  name               = "LambdaFomillerCongocoon"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_role_policy" {
  name        = "LambdaFomillerCongocoonPolicy"
  description = "IAM Policy for LambdaFomillerCongoon"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Sid" : "AllowCloudwatchLogging",
      "Effect" : "Allow",
      "Action" : [
        "logs:CreateLogStream",
        "logs:CreateLogDelivery",
        "logs:PutLogEvents"
      ],
      "Resource" : "arn:aws:logs:*:*:*"
      },
      {
        "Sid" : "ListObjectsInBucket",
        "Effect" : "Allow",
        "Action" : ["s3:ListBucket"],
        "Resource" : ["arn:aws:s3:::fomiller-dev"]
      },
      {
        "Sid" : "AllObjectActions",
        "Effect" : "Allow",
        "Action" : "s3:*Object",
        "Resource" : ["arn:aws:s3:::fomiller-dev/*"]
      },
      {
        "Sid" : "GetGmailSecret",
        "Effect" : "Allow",
        "Action" : "secretsmanager:GetSecretValue",
        "Resource" : [aws_secretsmanager_secret.gmail_congocoon_pass.arn]
      },
      {
        "Sid" : "ListDescribeSecret",
        "Effect" : "Allow",
        "Action" : "secretsmanager:DescribeSecret",
        "Action" : "secretsmanager:List*",
        "Resource" : ["*"]
      },
      {
        "Sid" : "KmsDecrypt",
        "Effect" : "Allow",
        "Action" : "kms:Decrypt",
        "Resource" : [aws_kms_key.chat_stat_master_kms_key.arn]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_role_policy.arn
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_event_rule" "lambda" {
  name                = "congocoon-lambda-interval"
  description         = "Trigger lambda every hour"
  schedule_expression = "rate(30 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.lambda.name
  target_id = "lambda"
  arn       = aws_lambda_function.lambda.arn
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda.arn

}

resource "aws_secretsmanager_secret" "gmail_congocoon_pass" {
  name       = "gmail-congocoon-pass"
  kms_key_id = data.aws_kms_key.chat_stat_master_kms_key.arn
}

resource "aws_secretsmanager_secret_version" "gmail_congocoon_pass" {
  secret_id     = aws_secretsmanager_secret.gmail_congocoon_pass.id
  secret_string = var.gmail_congocoon_pass
}

