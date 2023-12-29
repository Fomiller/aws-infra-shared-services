variable "eks_cluster_default_security_group_id" { type = string }
variable "subnet_ids_private" { type = list(string) }
variable "subnet_ids_public" { type = list(string) }
variable "vpc_id" { type = string }
