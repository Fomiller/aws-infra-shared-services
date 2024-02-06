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
  policy_arn = aws_iam_policy.timestream.arn
}

resource "aws_iam_role_policy_attachment" "eks_fargate_profile_logging" {
  role       = var.iam_role_name_eks_fargate_profile
  policy_arn = aws_iam_policy.eks_logging.arn
}

resource "aws_iam_role_policy_attachment" "eks_cluster_ec2_read" {
  role       = var.iam_role_name_eks_cluster
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "eks_node_groups_worker_policy" {
  role       = var.iam_role_name_eks_node_groups
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_node_groups_cni_policy" {
  role       = var.iam_role_name_eks_node_groups
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_node_groups_container_registry_policy" {
  role       = var.iam_role_name_eks_node_groups
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eks_node_elasticache_policy" {
  role       = var.iam_role_name_eks_node_groups
  policy_arn = "arn:aws:iam::aws:policy/AmazonElastiCacheReadOnlyAccess"
}
