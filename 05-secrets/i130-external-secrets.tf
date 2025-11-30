
resource "kubernetes_namespace" "external_secrets" {
  metadata {
    name = "external-secrets"
  }
}

resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "1.1.0"
  namespace  = kubernetes_namespace.external_secrets.metadata.0.name
}

resource "kubernetes_manifest" "scaleway_cluster_secret_store" {
  manifest = {
    apiVersion = "external-secrets.io/v1"
    kind       = "ClusterSecretStore"
    metadata = {
      name = "scaleway-secret-store"
    }
    spec = {
      provider = {
        scaleway = {
          region    = "fr-par"
          projectId = var.scw_project_id
          accessKey = {
            secretRef = {
              namespace = "default"
              name      = kubernetes_secret.scaleway.metadata[0].name
              key       = "access-key"
            }
          }
          secretKey = {
            secretRef = {
              namespace = "default"
              name      = kubernetes_secret.scaleway.metadata[0].name
              key       = "secret-key"
            }
          }
        }
      }
    }
  }
}
