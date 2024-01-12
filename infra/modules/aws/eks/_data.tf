data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.cluster.version}/amazon-linux-2-arm64/recommended/release_version"
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.cluster.id
}

# resource "terraform_data" "k8s_fargate_patcher" {
#   triggers_replace = {
#     endpoint = aws_eks_cluster.cluster.endpoint
#     ca_crt   = base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)
#     token    = data.aws_eks_cluster_auth.eks.token
#   }
#
#   provisioner "local-exec" {
#     command = <<EOH
# cat >/tmp/ca.crt <<EOF
# ${base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)}
# EOF
# kubectl \
#   --server="${aws_eks_cluster.cluster.endpoint}" \
#   --certificate_authority=/tmp/ca.crt \
#   --token="${data.aws_eks_cluster_auth.eks.token}" \
#   patch deployment coredns \
#   -n kube-system --type json \
#   -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
# EOH
#   }
#
#   lifecycle {
#     ignore_changes = [triggers_replace]
#   }
#
#   depends_on = [aws_eks_fargate_profile.kube_system]
# }
