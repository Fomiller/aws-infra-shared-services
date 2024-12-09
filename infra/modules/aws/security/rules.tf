resource "aws_security_group_rule" "eks_to_elasticache" {
  security_group_id        = aws_security_group.elasticache.id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.eks.id
}
