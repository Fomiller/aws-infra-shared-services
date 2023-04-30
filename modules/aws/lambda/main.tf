# module "congocoon" {
#  source = "git::https://github.com/Fomiller/tf-module-lambda.git" 
#  function_name    = var.lambda_name
#  role             = var.lambda_role
#  filename         = var.filename
#  handler          = var.handler
#  source_code_hash = var.source_code_hash
#  runtime          = var.runtime
#  memory_size      = var.memory_size
#  timeout          = var.timeout
# }
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
