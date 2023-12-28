resource "aws_ssm_parameter" "elasticache_cluster_configuration_endpoint_redis" {
  name  = "/${var.environment}/${var.namespace}-redis-configuration-endpoint"
  type  = "String"
  value = var.elasticache_cluster_configuration_endpoint_redis
}

resource "aws_ssm_parameter" "efs_id" {
  name  = "/${var.environment}/${var.namespace}-eks-efs-id"
  type  = "String"
  value = var.efs_id
}
