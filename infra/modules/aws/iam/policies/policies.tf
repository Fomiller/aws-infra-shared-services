resource "aws_iam_policy" "lambda_hello" {
  name        = "${local.namespace}LambdaHelloWorldPermission"
  description = "IAM Policy for LambdaHelloWorld"
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

resource "aws_iam_policy" "ecs_events" {
  name        = "${local.namespace}EcsRunTaskPermission"
  description = "Policy for Running chat stat ECS tasks "

  policy = <<DOC
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "ecs:RunTask",
            "Resource": "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:task-definition/fomiller-chat-stat"
        }
    ]
}
DOC
}

resource "aws_iam_policy" "eks_logging" {
  name        = "${local.namespace}FargateLoggingPolicy"
  description = "IAM Policy for EKS Fargate Logging"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Action" : [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:DescribeLogStreams",
        "logs:PutLogEvents",
        "logs:PutRetentionPolicy"
      ],
      "Resource" : "*"
    }]
    }
  )
}

resource "aws_iam_policy" "timestream" {
  name        = "${local.namespace}FargateElasticachePolicy"
  description = "IAM Policy for EKS Fargate Elastiache"
  policy      = data.aws_iam_policy_document.timestream.json
}
