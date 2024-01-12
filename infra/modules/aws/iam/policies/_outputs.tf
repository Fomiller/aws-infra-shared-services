output "iam_policy_ecs_events" {
  value = aws_iam_policy.ecs_events.arn
}

output "iam_policy_lambda_hello" {
  value = aws_iam_policy.lambda_hello.arn
}
