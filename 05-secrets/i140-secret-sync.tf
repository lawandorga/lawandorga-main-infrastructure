resource "kubernetes_manifest" "lawandorga_backend_service_external_secret" {
  manifest = {
    apiVersion = "external-secrets.io/v1"
    kind       = "ExternalSecret"
    metadata = {
      name      = "lawandorga-backend-service"
      namespace = kubernetes_namespace.external_secrets.metadata.0.name
    }
    spec = {
      refreshInterval = "1h0m0s"
      secretStoreRef = {
        name = "scaleway-secret-store"
        kind = "ClusterSecretStore"
      }
      target = {
        name           = "lawandorga-backend-service"
        creationPolicy = "Owner"
      }
      data = [
        {
          secretKey = "data"
          remoteRef = {
            key = "id:5bbadfac-8fb9-47e5-855b-41397c621b56"
          }
        }
      ]
    }
  }
}
