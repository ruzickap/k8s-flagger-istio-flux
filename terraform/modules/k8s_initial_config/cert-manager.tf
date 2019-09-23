resource "kubernetes_namespace" "namespace_cert-manager" {
  metadata {
    labels = {
      "certmanager.k8s.io/disable-validation" = "true"
    }
    name = "cert-manager"
  }
}

data "http" "crd_cert-manager" {
  url = "https://raw.githubusercontent.com/jetstack/cert-manager/release-${replace(var.helm_cert-manager_version, "/^v?(\\d+\\.\\d+)\\.\\d+$/", "$1")}/deploy/manifests/00-crds.yaml"
}

resource "null_resource" "cert-manager-crds" {
  depends_on = [kubernetes_namespace.namespace_cert-manager]
  triggers = {
    template_file_cert-manager_application_sha1 = "${sha1("${data.http.crd_cert-manager.body}")}"
  }

  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig=${var.kubeconfig} -f ${data.http.crd_cert-manager.url}"
  }

  provisioner "local-exec" {
    when = "destroy"
    command = "kubectl delete --kubeconfig=${var.kubeconfig} -f ${data.http.crd_cert-manager.url}"
  }
}

data "helm_repository" "repository_cert-manager" {
  name = "cert-manager"
  url  = "https://charts.jetstack.io"
}

resource "helm_release" "cert-manager" {
  depends_on = [null_resource.cert-manager-crds, kubernetes_cluster_role_binding.tiller]
  name       = "cert-manager"
  repository = "${data.helm_repository.repository_cert-manager.metadata.0.name}"
  chart      = "cert-manager"
  version    = var.helm_cert-manager_version
  namespace  = kubernetes_namespace.namespace_cert-manager.id

  set {
    name  = "webhook.enabled"
    value = "false"
  }
}


############################
# Certificates
############################

resource "kubernetes_secret" "secret" {
  metadata {
    name      = "cert-manager-dns-config-secret"
    namespace = kubernetes_namespace.namespace_cert-manager.id
  }
  data = {
    # Azure DNS client secret (for Azure DNS)
    CLIENT_SECRET     = var.client_secret
    # AWS Secret access key (for Route53)
    secret-access-key = var.secret_access_key
  }
}

data "template_file" "cert-manager-clusterissuer" {
  template = file("${path.module}/files/cert-manager-${var.cloud_platform}-clusterissuer.yaml.tmpl")
  vars = {
    email                   = var.email
    hostedZoneName          = var.dns_zone_name
    # Azure DNS access credentials (for Azure DNS)
    clientID                = var.client_id
    resourceGroupName       = var.resource_group_name
    resource_group_name_dns = var.resource_group_name_dns
    subscriptionID          = var.subscription_id
    tenantID                = var.tenant_id
    # AWS Access key (for Route53)
    accesskeyid             = var.accesskeyid
    location                = var.location
  }
}

resource "null_resource" "cert-manager-clusterissuer" {
  depends_on = [helm_release.cert-manager]

  triggers = {
    template_file_cert-manager-clusterissuer_sha1 = "${sha1("${data.template_file.cert-manager-clusterissuer.rendered}")}"
  }

  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig=${var.kubeconfig} -f -<<EOF\n${data.template_file.cert-manager-clusterissuer.rendered}\nEOF"
  }

  provisioner "local-exec" {
    when = "destroy"
    command = "kubectl delete --kubeconfig=${var.kubeconfig} -f -<<EOF\n${data.template_file.cert-manager-clusterissuer.rendered}\nEOF"
  }
}

data "template_file" "cert-manager-certificate" {
  template = file("${path.module}/files/cert-manager-certificate.yaml.tmpl")
  vars = {
    cloud_platform          = var.cloud_platform
    dnsName                 = var.dns_zone_name
    letsencrypt_environment = var.letsencrypt_environment
  }
}

resource "null_resource" "cert-manager-certificate" {
  depends_on = [null_resource.cert-manager-clusterissuer]

  triggers = {
    template_file_cert-manager-certificate_sha1 = "${sha1("${data.template_file.cert-manager-certificate.rendered}")}"
  }

  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig=${var.kubeconfig} -f -<<EOF\n${data.template_file.cert-manager-certificate.rendered}\nEOF"
  }

  provisioner "local-exec" {
    when = "destroy"
    command = "kubectl delete --kubeconfig=${var.kubeconfig} -f -<<EOF\n${data.template_file.cert-manager-certificate.rendered}\nEOF"
  }
}

resource "null_resource" "cert-manager-certificate-label" {
  depends_on = [null_resource.cert-manager-certificate]

  provisioner "local-exec" {
    command = "kubectl wait --kubeconfig=${var.kubeconfig} --for=condition=ready -n cert-manager certificate/ingress-cert-${var.letsencrypt_environment} --timeout=10m && kubectl annotate --kubeconfig=${var.kubeconfig} secret ingress-cert-${var.letsencrypt_environment} -n cert-manager kubed.appscode.com/sync='app=kubed'"
  }

  provisioner "local-exec" {
    when = "destroy"
    command = "kubectl annotate secret --kubeconfig=${var.kubeconfig} ingress-cert-${var.letsencrypt_environment} -n cert-manager kubed.appscode.com/sync-"
  }
}
