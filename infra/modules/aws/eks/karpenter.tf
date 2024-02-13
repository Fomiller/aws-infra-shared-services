module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "20.2.1"
  
  cluster_name = aws_eks_cluster.cluster.name

  enable_irsa                     = true
  irsa_oidc_provider_arn          = aws_iam_openid_connect_provider.eks.arn
  irsa_namespace_service_accounts = ["karpenter:karpenter"]

  create_iam_role   = true
  create_node_iam_role = true
  iam_role_use_name_prefix = false
  node_iam_role_use_name_prefix = false
  iam_role_name = "KarpenterController-${aws_eks_cluster.cluster.name}"
  node_iam_role_name = "KarpenterNodeRole-${aws_eks_cluster.cluster.name}"
  # node_iam_role_arn = var.iam_role_arn_eks_node_groups
}
