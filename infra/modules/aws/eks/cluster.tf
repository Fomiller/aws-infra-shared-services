resource "aws_eks_cluster" "cluster" {
  name     = "${var.namespace}-cluster"
  role_arn = var.iam_role_arn_eks_cluster

  enabled_cluster_log_types = ["api"]

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]

    subnet_ids = concat(var.subnet_ids_private, var.subnet_ids_public)
    security_group_ids = [
      var.security_group_id_eks
    ]
  }

}

