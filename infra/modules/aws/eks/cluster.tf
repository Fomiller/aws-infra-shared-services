resource "aws_eks_cluster" "cluster" {
  name     = "${var.namespace}-cluster"
  role_arn = var.iam_role_arn_eks_cluster

  enabled_cluster_log_types = ["api"]

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]

    subnet_ids = concat(var.subnet_ids_private, var.subnet_ids_public)
  }
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
}

resource "aws_ec2_tag" "cluster_primary_security_group" {
  # This should not affect the name of the cluster primary security group
  # Ref: https://github.com/terraform-aws-modules/terraform-aws-eks/pull/2006
  # Ref: https://github.com/terraform-aws-modules/terraform-aws-eks/pull/2008
  for_each = local.security_group_tags

  resource_id = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
  key         = each.key
  value       = each.value
}
