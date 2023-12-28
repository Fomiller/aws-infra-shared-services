output "aws_load_balancer_controller_role_arn" {
  value = aws_iam_role.aws_load_balancer_controller.arn
}

output "eks_cluster_default_security_group_id" {
  value = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}
