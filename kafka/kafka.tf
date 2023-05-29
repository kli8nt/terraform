resource "kubernetes_namespace" "kafka_namespace" {
  metadata {
    name = "kafka"
    annotations = {
      name = "kafka"
    }

    labels = {
      mylabel = "kafka"
    }
  }
}

resource "kubernetes_manifest" "zookeeper_svc" {
  manifest  = yamldecode(file("k8s/zookeeper-svc.yml"))
}

resource "kubernetes_manifest" "zookeeper_dep" {
  manifest  = yamldecode(file("k8s/zookeeper-dep.yml"))
}

resource "kubernetes_manifest" "kafka_dep" {
  manifest  = yamldecode(file("k8s/kafka-dep.yml"))
  depends_on = [ kubernetes_manifest.zookeeper_dep, kubernetes_manifest.zookeeper_svc ]
}

resource "kubernetes_manifest" "kafka_svc" {
  manifest  = yamldecode(file("k8s/kafka-svc.yml"))
}

