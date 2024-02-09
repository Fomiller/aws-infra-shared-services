module "karpenter" {
  source = "terraform-aws-modules/eks/aws//modules/karpenter"

  cluster_name = aws_eks_cluster.cluster.name

  enable_irsa                     = true
  irsa_oidc_provider_arn          = aws_iam_openid_connect_provider.eks.arn
  irsa_namespace_service_accounts = ["karpenter:karpenter"]

  create_iam_role   = true
  create_node_iam_role = true
  node_iam_role_name = "KarpenterNodeRole-${aws_eks_cluster.cluster.name}"
  # node_iam_role_arn = var.iam_role_arn_eks_node_groups
}
