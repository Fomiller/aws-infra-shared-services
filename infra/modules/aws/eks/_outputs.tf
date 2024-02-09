output "aws_load_balancer_controller_role_arn" {
  value = aws_iam_role.aws_load_balancer_controller.arn
}

output "eks_cluster_default_security_group_id" {
  value = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}

output "cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "cluster_id" {
  value = aws_eks_cluster.cluster.id
}

output "karpenter_controller_name" {
  value = module.karpenter.iam_role_name
}

output "karpenter_node_name" {
  value = module.karpenter.node_iam_role_name
}

output "karpenter_iam_unique" {
  value = module.karpenter.iam_role_unique_id
}
