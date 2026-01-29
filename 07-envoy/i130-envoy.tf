resource "kubernetes_namespace" "envoy_gateway_system" {
  metadata {
    name = "envoy-gateway-system"
  }
}

resource "helm_release" "envoy_gateway" {
  name       = "envoy-gateway"
  repository = "oci://docker.io/envoyproxy"
  chart      = "gateway-helm"
  version    = "v1.2.4" # or latest
  namespace  = kubernetes_namespace.envoy_gateway_system.metadata.0.name

  set = [
    {
      name  = "createNamespace"
      value = "false"
    }
  ]
}

resource "kubernetes_manifest" "gateway_class" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "GatewayClass"
    metadata = {
      name = "envoy"
    }
    spec = {
      controllerName = "gateway.envoyproxy.io/gatewayclass-controller"
    }
  }
  depends_on = [helm_release.envoy_gateway]
}

resource "kubernetes_manifest" "gateway" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "Gateway"
    metadata = {
      name      = "lawandorga-gateway"
      namespace = "default" # or your app namespace
    }
    spec = {
      gatewayClassName = "envoy"
      listeners = [
        {
          name     = "http"
          protocol = "HTTP"
          port     = 80
          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
        },
        {
          name     = "https-frontend"
          protocol = "HTTPS"
          port     = 443
          hostname = "*.law-orga.de"
          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "frontend-certificate"
              }
            ]
          }
        },
        {
          name     = "https-backend"
          protocol = "HTTPS"
          port     = 443
          hostname = "backend.law-orga.de"
          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "backend-certificate"
              }
            ]
          }
        },
        {
          name     = "https-auth"
          protocol = "HTTPS"
          port     = 443
          hostname = "auth.law-orga.de"
          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "backend-certificate"
              }
            ]
          }
        },
        {
          name     = "https-statistics"
          protocol = "HTTPS"
          port     = 443
          hostname = "statistics.law-orga.de"
          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "lawandorga-statistics-frontend-certificate"
              }
            ]
          }
        }
      ]
      addresses = [
        {
          type  = "IPAddress"
          value = "51.159.9.224"
        }
      ]
    }
  }
  depends_on = [kubernetes_manifest.gateway_class]
}
