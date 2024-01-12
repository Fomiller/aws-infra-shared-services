output "elasticache_cluster_configuration_endpoint_redis" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}
