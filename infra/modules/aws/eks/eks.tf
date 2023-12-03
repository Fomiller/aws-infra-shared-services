resource "aws_eks_cluster" "cluster" {
  name     = "${var.namespace}-cluster"
  role_arn = var.iam_role_arn_eks_cluster

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]

    subnet_ids = concat(var.subnet_ids_private, var.subnet_ids_public)
  }

}


resource "aws_eks_fargate_profile" "kube_system" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "kube-system"
  pod_execution_role_arn = var.iam_role_arn_eks_fargate_profile

  subnet_ids = var.subnet_ids_private

  selector {
    namespace = "kube-system" # this might need to be moved to chat-stat repo
  }
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.cluster.id
}

resource "terraform_data" "k8s_fargate_patcher" {
  triggers = {
    endpoint = aws_eks_cluster.cluster.endpoint
    ca_crt   = base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)
    token    = data.aws_eks_cluster_auth.eks.token
  }

  provisioner "local-exec" {
    command = <<EOH
cat >/tmp/ca.crt <<EOF
${base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)}
EOF
kubectl \
  --server="${aws_eks_cluster.cluster.endpoint}" \
  --certificate_authority=/tmp/ca.crt \
  --token="${data.aws_eks_cluster_auth.eks.token}" \
  patch deployment coredns \
  -n kube-system --type json \
  -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
EOH
  }

  lifecycle {
    ignore_changes = [triggers]
  }

  depends_on = [aws_eks_fargate_profile.kube_system]
}
