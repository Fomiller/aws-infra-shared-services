resource "aws_elasticache_cluster" "redis" {
  cluster_id        = "${var.namespace}-redis"
  engine            = "redis"
  engine_version    = "7.1"
  node_type         = "cache.t4g.micro"
  num_cache_nodes   = 1
  port              = 6379
  apply_immediately = true
  subnet_group_name = aws_elasticache_subnet_group.private.name
  security_group_ids = [
    var.security_group_id_elasticache
  ]

  log_delivery_configuration {
    destination      = var.cloudwatch_log_group_name_redis
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }

}

resource "aws_elasticache_subnet_group" "private" {
  name       = "${var.namespace}-private-subnet-group"
  subnet_ids = var.subnet_ids_private
}
