resource "helm_release" "aws_load_balancer_controller" {
  name = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.5.5"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.cluster.id
  }
  set {
    name  = "image.tag"
    value = "v2.5.1"
  }
  set {
    name  = "replicaCount"
    value = 1
  }
  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_load_balancer_controller.arn
  }
  # EKS Fargate specific
  set {
    name  = "region"
    value = "us-east-1"
  }
  set {
    name  = "vpcId"
    value = var.vpc_id
  }
  depends_on = [helm_release.karpenter]
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns"
  chart      = "external-dns"
  namespace  = "kube-system"

  set {
    name  = "provider"
    value = "aws"
  }
  set {
    name  = "domainFilters[0]"
    value = "${var.namespace}-cluster.dev.aws.fomillercloud.com"
  }
  set {
    name  = "policy"
    value = "sync"
  }
  set {
    name  = "aws.region"
    value = "us-east-1"
  }
  set {
    name  = "serviceAccount.name"
    value = "external-dns"
  }
  set {
    name  = "serviceAccount.create"
    value = true
  }
  set {
    name  = "rbac.create"
    value = true
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_dns.arn
  }
  depends_on = [helm_release.karpenter]
}

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "5.35.0"
  values           = [file("values/argocd.yaml")]
  depends_on       = [helm_release.karpenter]
}

resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  namespace  = "kube-system"

  set {
    name  = "env.AWS_REGION"
    value = "us-east-1"
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_secrets.arn
  }
  set {
    name  = "webhook.port"
    value = 9443
  }
  depends_on = [helm_release.karpenter]
}

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true
  name             = "karpenter"
  repository       = "oci://public.ecr.aws/karpenter"
  chart            = "karpenter"
  version          = "v0.34.0"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.karpenter.iam_role_arn
  }

  set {
    name  = "settings.clusterName"
    value = aws_eks_cluster.cluster.name
  }

  set {
    name  = "settings.clusterEndpoint"
    value = aws_eks_cluster.cluster.endpoint
  }
  depends_on = [module.karpenter]
}

# resource "helm_release" "metrics-server" {
#   name = "metrics-server"
#
#   repository = "https://kubernetes-sigs.github.io/metrics-server/"
#   chart      = "metrics-server"
#   namespace  = "kube-system"
#   version    = "3.8.2"
#
#   set {
#     name  = "metrics.enabled"
#     value = false
#   }
#
#   depends_on = [aws_eks_fargate_profile.kube_system]
# }

