# output "load_balancer_ip" {
#   value = aws_lb.aws_infra.dns_name
# }

output "subnet_ids_private" {
  value = aws_subnet.private[*].id
}

output "subnet_ids_public" {
  value = aws_subnet.public[*].id
}

output "db_subnet_group_name_private" {
  value = aws_db_subnet_group.private.name
}

output "vpc_id" {
  value = aws_vpc.aws_infra.id
}
#
# output "target_group" {
#   value = aws_lb_target_group.aws_infra.id
# }
