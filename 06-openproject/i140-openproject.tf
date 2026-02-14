resource "kubernetes_namespace" "openproject" {
  metadata {
    name = "openproject"
  }
}

resource "helm_release" "openproject" {
  name       = "openproject"
  repository = "https://charts.openproject.org"
  chart      = "openproject"
  version    = "13.0.2"
  namespace  = kubernetes_namespace.openproject.metadata.0.name

  values = [
    yamlencode({
      ingress = {
        enabled = true
        host    = "openproject.law-orga.de"
        tls = {
          enabled    = true
          secretName = var.certificate_name
        }
      }
      persistence = {
        accessModes = ["ReadWriteOnce"]
      }
      postgresql = {
        auth = {
          username         = "openproject"
          password         = "openproject"
          database         = "openproject"
          postgresPassword = "openproject"
        }
      }
    })
  ]
}
