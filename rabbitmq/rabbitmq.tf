resource "kubernetes_namespace" "rabbitmq_namespace" {
  metadata {
    name = "rabbitmq"
    annotations = {
      name = "rabbitmq"
    }

    labels = {
      mylabel = "rabbitmq"
    }
  }
}

resource "helm_release" "install_rabbitmq_operator" {
    name       = "rabbit-operator"
    repository = "https://charts.bitnami.com/bitnami"
    chart      = "rabbitmq-cluster-operator"
    namespace  = kubernetes_namespace.rabbitmq_namespace.metadata[0].name
    atomic = true
    depends_on = [
        kubernetes_namespace.rabbitmq_namespace
    ]
}

resource "kubernetes_manifest" "rabbitmq" {
  manifest  = yamldecode(file("k8s/rabbitmq.yml"))
  depends_on = [ helm_release.install_rabbitmq_operator ]
}

output "rabbitmq_username" {
    value = "to get rabbitMQ's username, execute: kubectl get secret rabbitmq-cluster-default-user -o jsonpath='{.data.username}' -n rabbitmq | base64 -d"
}

output "rabbitmq_password" {
    value = "to get rabbitMQ's username, execute: kubectl get secret rabbitmq-cluster-default-user -o jsonpath='{.data.password}' -n rabbitmq | base64 -d"
}