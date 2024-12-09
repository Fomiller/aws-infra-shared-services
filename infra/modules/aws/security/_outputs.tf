output "security_group_id_elasticache" {
  value = aws_security_group.elasticache.id
}

output "security_group_id_eks" {
  value = aws_security_group.eks.id
}

output "security_group_id_rds" {
  value = aws_security_group.rds_db_sg.id
}

output "security_group_id_bastion" {
  value = aws_security_group.bastion_sg.id
}
