resource "aws_iam_role" "lambda_hello" {
  name               = "${local.namespace}LambdaHelloWorld"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}
