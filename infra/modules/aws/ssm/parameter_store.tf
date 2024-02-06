resource "aws_ssm_parameter" "efs_id" {
  name  = "/${var.environment}/${var.namespace}-eks-efs-id"
  type  = "String"
  value = var.efs_id
}
