provider "kubernetes" {
  config_path    = var.kubeconfig_path
  config_context = var.kube_context
}


provider "helm" {
  kubernetes {
    config_path    = var.kubeconfig_path
    config_context = var.kube_context
  }
}

output "Kubeconfig_Path" {
  value = var.kubeconfig_path
}

output "Kube_context" {
  value = var.kube_context
}