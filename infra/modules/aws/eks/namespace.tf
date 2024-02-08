resource "kubernetes_namespace" "chat_stat" {
  metadata {
    name = "chat-stat"
  }
}
