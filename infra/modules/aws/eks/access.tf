resource "aws_eks_access_entry" "chat_stat" {
  for_each          = data.aws_iam_roles.sso.arns
  cluster_name      = aws_eks_cluster.cluster.name
  principal_arn     = each.value
  kubernetes_groups = ["admins"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "chat_stat" {
  for_each      = data.aws_iam_roles.sso.arns
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = each.value

  access_scope {
    type = "cluster"
  }
  depends_on = [aws_eks_access_entry.chat_stat]
}
