output "iam_role_name_lambda_hello" {
  value = aws_iam_role.lambda_hello.name
}

output "iam_role_name_eks_cluster" {
  value = aws_iam_role.eks_cluster.name
}

output "iam_role_arn_eks_cluster" {
  value = aws_iam_role.eks_cluster.arn
}

output "iam_role_arn_eks_fargate_profile" {
  value = aws_iam_role.eks_fargate_profile.arn
}

output "iam_role_name_eks_fargate_profile" {
  value = aws_iam_role.eks_fargate_profile.name
}
