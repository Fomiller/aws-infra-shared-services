output "iam_policy_ecs_events" {
  value = aws_iam_policy.ecs_events.arn
}

output "iam_policy_lambda_hello" {
  value = aws_iam_policy.lambda_hello.arn
}

output "iam_policy_document_lambda_json" {
  value = data.aws_iam_policy_document.lambda.json
}

output "iam_policy_document_eventbridge_json" {
  value = data.aws_iam_policy_document.eventbridge.json
}
