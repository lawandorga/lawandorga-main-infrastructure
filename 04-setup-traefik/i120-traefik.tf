resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }
}

resource "helm_release" "traefik" {
  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  version    = "21.2.0"
  namespace  = kubernetes_namespace.traefik.metadata.0.name

  set {
    name  = "ports.web.redirectTo"
    value = "websecure"
  }
}
