# kics-scan ignore

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
}

# This reource must be referenced in any "helm_repository", because
# during the deleting of the cluster this may be deleted first and then helm
# stoped working and all helm releases will "hang".
# Best would be sto se provider.helm dependent on this resource - but it's not
# supported...
resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "tiller"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.tiller.metadata.0.name
    namespace = "kube-system"
  }
}

provider "helm" {
  version         = "0.10.6"
  service_account = kubernetes_service_account.tiller.metadata.0.name
  debug           = true
  kubernetes {
    config_path = var.kubeconfig
  }
}
