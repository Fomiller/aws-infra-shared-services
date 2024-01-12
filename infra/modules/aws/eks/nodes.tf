resource "aws_eks_node_group" "public_nodes" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "public-nodes"
  node_role_arn   = var.iam_role_arn_eks_node_groups

  ami_type        = "AL2_ARM_64"
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)

  subnet_ids = var.subnet_ids_public

  capacity_type  = "ON_DEMAND"
  instance_types = ["t4g.small"]

  # maximum pod limit per instance type
  # https://gtsopour.medium.com/aws-eks-maximum-number-of-pods-per-ec2-node-instance-bfbe658cecad
  # https://github.com/awslabs/amazon-eks-ami/blob/master/files/eni-max-pods.txt
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }

  # launch_template {
  #   name    = aws_launch_template.eks-with-disks.name
  #   version = aws_launch_template.eks-with-disks.latest_version
  # }
}
