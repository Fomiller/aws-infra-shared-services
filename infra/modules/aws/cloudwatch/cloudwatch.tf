resource "aws_cloudwatch_log_group" "eks" {
  # The log group name format is /aws/eks/<cluster-name>/cluster
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  name              = "/aws/eks/${var.namespace}-cluster/cluster"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "redis" {
  name              = "/aws/elasticache/${var.namespace}-redis"
  retention_in_days = 3
}

