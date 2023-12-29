resource "aws_iam_role_policy_attachment" "lambda_hello" {
  role       = var.iam_role_name_lambda_hello
  policy_arn = aws_iam_policy.lambda_hello.arn
}

resource "aws_iam_role_policy_attachment" "eks_fargate_profile" {
  role       = var.iam_role_name_eks_fargate_profile
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_fargate_profile_elasticache" {
  role       = var.iam_role_name_eks_fargate_profile
  policy_arn = aws_iam_policy.elasticache.arn
}

resource "aws_iam_role_policy_attachment" "eks_fargate_profile_logging" {
  role       = var.iam_role_name_eks_fargate_profile
  policy_arn = aws_iam_policy.eks_logging.arn
}

resource "aws_iam_role_policy_attachment" "eks_cluster_ec2_read" {
  role       = var.iam_role_name_eks_cluster
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
