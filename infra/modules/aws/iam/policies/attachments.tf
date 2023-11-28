resource "aws_iam_role_policy_attachment" "lambda_hello" {
  role       = var.iam_role_name_lambda_hello
  policy_arn = aws_iam_policy.lambda_hello.arn
}

# resource "aws_iam_role_policy_attachment" "eks_cluster" {
#   role       = var.iam_role_name_eks_cluster
#   policy_arn = aws_iam_policy.eks_cluster.arn
# }

