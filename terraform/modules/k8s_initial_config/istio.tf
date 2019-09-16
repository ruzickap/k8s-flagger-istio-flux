resource "kubernetes_namespace" "namespace_istio-system" {
  metadata {
    labels = {
      "app"             = "kubed"
      "istio-injection" = "disabled"
    }
    name = "istio-system"
  }
}

data "helm_repository" "repository_istio" {
  name = "istio"
  url  = "https://gcsweb.istio.io/gcs/istio-release/releases/${var.helm_istio_version}/charts/"
}

resource "helm_release" "istio-init" {
  depends_on = [kubernetes_cluster_role_binding.tiller]
  name       = "istio-init"
  repository = "${data.helm_repository.repository_istio.metadata.0.name}"
  chart      = "istio-init"
  version    = var.helm_istio_version
  namespace  = kubernetes_namespace.namespace_istio-system.id
}

resource "null_resource" "istio-init-delay" {
  depends_on = [helm_release.istio-init]
  provisioner "local-exec" {
    command = "sleep 100"
  }
}

resource "helm_release" "istio" {
  depends_on = [null_resource.istio-init-delay]
  name       = "istio"
  repository = "${data.helm_repository.repository_istio.metadata.0.name}"
  chart      = "istio"
  version    = var.helm_istio_version
  namespace  = kubernetes_namespace.namespace_istio-system.id
  timeout    = 1000

  set {
    name  = "gateways.istio-ingressgateway.autoscaleMax"
    value = "1"
  }
  set {
    name  = "gateways.istio-ingressgateway.autoscaleMin"
    value = "1"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[0].name"
    value = "status-port"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[0].port"
    value = "15020"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[0].targetPort"
    value = "15020"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[1].name"
    value = "http"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[1].nodePort"
    value = "31380"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[1].port"
    value = "80"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[1].targetPort"
    value = "80"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[2].name"
    value = "https"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[2].nodePort"
    value = "31390"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[2].port"
    value = "443"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[3].name"
    value = "postgresql"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[3].nodePort"
    value = "31400"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[3].port"
    value = "5432"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[4].name"
    value = "postgresql-repl"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[4].nodePort"
    value = "31401"
  }
  set {
    name  = "gateways.istio-ingressgateway.ports[4].port"
    value = "5433"
  }
  set {
    name  = "gateways.istio-ingressgateway.sds.enabled"
    value = "true"
  }
  set {
    name  = "global.disablePolicyChecks"
    value = "true"
  }
  set {
    name  = "global.k8sIngress.enableHttps"
    value = "true"
  }
  set {
    name  = "global.k8sIngress.enabled"
    value = "true"
  }
  set {
    name  = "global.proxy.autoInject"
    value = "disabled"
  }
  set {
    name  = "grafana.enabled"
    value = "true"
  }
  set {
    name  = "kiali.contextPath"
    value = "/"
  }
  set {
    name  = "kiali.createDemoSecret"
    value = "true"
  }
  set {
    name  = "kiali.dashboard.grafanaURL"
    value = "http://grafana.${var.dns_zone_name}/"
  }
  set {
    name  = "kiali.dashboard.jaegerURL"
    value = "http://jaeger.${var.dns_zone_name}/"
  }
  set {
    name  = "kiali.enabled"
    value = "true"
  }
  set {
    name  = "pilot.traceSampling"
    value = "100"
  }
  set {
    name  = "sidecarInjectorWebhook.enableNamespacesByDefault"
    value = "true"
  }
  set {
    name  = "sidecarInjectorWebhook.enabled"
    value = "true"
  }
  set {
    name  = "tracing.enabled"
    value = "true"
  }
}

data "template_file" "istio-gateway" {
  depends_on = [helm_release.istio]
  template = file("${path.module}/files/istio-gateway.yaml.tmpl")
  vars = {
    letsencrypt_environment = var.letsencrypt_environment
  }
}

resource "null_resource" "istio-gateway" {
  depends_on = [helm_release.istio]

  triggers = {
    template_file_istio-gateway_sha1 = "${sha1("${data.template_file.istio-gateway.rendered}")}"
  }

  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig=${var.kubeconfig} -f -<<EOF\n${data.template_file.istio-gateway.rendered}\nEOF"
  }
}

data "template_file" "istio-services" {
  template = file("${path.module}/files/istio-services.yaml.tmpl")
  vars = {
    dnsName                 = var.dns_zone_name
    letsencrypt_environment = var.letsencrypt_environment
  }
}

resource "null_resource" "istio-services" {
  depends_on = [helm_release.istio]

  triggers = {
    template_file_istio-services_sha1 = "${sha1("${data.template_file.istio-services.rendered}")}"
  }

  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig=${var.kubeconfig} -f -<<EOF\n${data.template_file.istio-services.rendered}\nEOF"
  }
}
