resource "kubernetes_service_account" "fargate_chat_stat" {
  metadata {
    name      = "fargate-chat-stat"
    namespace = "chat-stat"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.chat_stat_logger.arn
    }
  }
  depends_on = [kubernetes_namespace.chat_stat]
}

resource "kubernetes_cluster_role_binding_v1" "fargate_chat_stat" {
  metadata {
    name = "fargate-chat-stat"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = aws_iam_role.chat_stat_logger.name
  }
  subject {
    kind      = "User"
    name      = "admin"
    api_group = "rbac.authorization.k8s.io"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "fargate-chat-stat"
    namespace = "chat-stat"
  }
}
