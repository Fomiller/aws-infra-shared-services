output "security_group_id_elasticache" {
  value = aws_security_group.elasticache.id
}

output "security_group_id_eks" {
  value = aws_security_group.eks.id
}
