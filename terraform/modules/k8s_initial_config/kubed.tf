data "helm_repository" "repository_kubed" {
  name = "kubed"
  url  = "https://charts.appscode.com/stable/"
}

resource "helm_release" "kubed" {
  depends_on = [kubernetes_cluster_role_binding.tiller]
  name       = "kubed"
  repository = "${data.helm_repository.repository_kubed.metadata.0.name}"
  chart      = "kubed"
  version    = var.helm_kubed_version
  namespace  = "kubed"

  set {
    name  = "apiserver.enabled"
    value = "false"
  }
  set {
    name  = "config.clusterName"
    value = "${var.full_kubernetes_cluster_name}"
  }
}
