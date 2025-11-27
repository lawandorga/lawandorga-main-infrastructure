resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.14.0" # or latest
  namespace  = kubernetes_namespace.nginx.metadata.0.name

  set = [
    {
      name  = "controller.kind"
      value = "DaemonSet"
    },
    {
      name  = "controller.ingressClassResource.name"
      value = "nginx"
    },
    {
      name  = "controller.ingressClassResource.default"
      value = true
    },
    {
      name  = "controller.daemonset.useHostPort"
      value = false
    },
    {
      name  = "controller.service.externalTrafficPolicy"
      value = "Local"
    },
    {
      name  = "controller.publishService.enabled"
      value = true
    },
    {
      name  = "controller.resources.requests.memory"
      type  = "string"
      value = "140Mi"
    },
    {
      name  = "controller.allowSnippetAnnotations"
      value = "true"
    },
    {
      name  = "controller.service.loadBalancerIP"
      value = "51.159.10.204"
    },
    {
      name  = "controller.service.nodePorts.http"
      value = "32628"
    },
    {
      name  = "controller.service.nodePorts.https"
      value = "30806"
    }
  ]
}
