resource "kubernetes_namespace" "argo_cd" {
  metadata {
    name = "argo-cd"
  }
}

resource "helm_release" "argocd" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.8.2"
  namespace  = kubernetes_namespace.argo_cd.metadata.0.name

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  #   set {
  #     name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
  #     value = "nlb"
  #   }
}
