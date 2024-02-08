locals {
  security_group_tags = {
    "karpenter.sh/discovery" = aws_eks_cluster.cluster.name
  }
}
