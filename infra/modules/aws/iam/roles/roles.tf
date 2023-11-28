resource "aws_iam_role" "lambda_hello" {
  name               = "${title(var.namespace)}LambdaHelloWorld"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_role" "eks_cluster" {
  name               = "${title(var.namespace)}EksCluster"
  assume_role_policy = data.aws_iam_policy_document.eks.json
}
