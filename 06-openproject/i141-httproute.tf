resource "kubernetes_manifest" "openproject_route" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "HTTPRoute"
    metadata = {
      name      = "openproject-route"
      namespace = kubernetes_namespace.openproject.metadata.0.name
    }
    spec = {
      parentRefs = [
        {
          name      = "lawandorga-gateway"
          namespace = "default"
        }
      ]
      hostnames = ["openproject.law-orga.de"]
      rules = [
        {
          matches = [
            {
              path = {
                type  = "PathPrefix"
                value = "/"
              }
            }
          ]
          backendRefs = [
            {
              name      = "openproject"
              namespace = "openproject"
              port      = 8080
            }
          ]
        }
      ]
    }
  }
}
