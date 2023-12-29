resource "aws_efs_file_system" "eks" {
  creation_token = "eks"

  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true

  # lifecycle_policy {
  #   transition_to_ia = "AFTER_30_DAYS"
  # }

  tags = {
    Name = "eks"
  }
}

resource "aws_efs_mount_target" "zone-a" {
  file_system_id = aws_efs_file_system.eks.id
  subnet_id      = var.subnet_ids_public[0]
  security_groups = [
    var.eks_cluster_default_security_group_id
  ]
}

resource "aws_efs_mount_target" "zone-b" {
  file_system_id = aws_efs_file_system.eks.id
  subnet_id      = var.subnet_ids_public[1]
  security_groups = [
    var.eks_cluster_default_security_group_id
  ]
}

