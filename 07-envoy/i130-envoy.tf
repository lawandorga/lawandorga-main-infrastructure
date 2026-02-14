resource "kubernetes_namespace" "envoy_gateway_system" {
  metadata {
    name = "envoy-gateway-system"
  }
}

resource "helm_release" "envoy_gateway" {
  name       = "envoy-gateway"
  repository = "oci://docker.io/envoyproxy"
  chart      = "gateway-helm"
  version    = "v1.5.8"
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
      namespace = "default"
    }
    spec = {
      gatewayClassName = "envoy"
      listeners = [
        {
          name     = "http"
          protocol = "HTTP"
          port     = 80
        },
        {
          name     = "https-frontend-www"
          protocol = "HTTPS"
          port     = 443
          hostname = "www.law-orga.de"
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
          name     = "https-frontend-apex"
          protocol = "HTTPS"
          port     = 443
          hostname = "law-orga.de"
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
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "lawandorga-backend-service-certificate"
              }
            ]
          }
        },
        {
          name     = "https-auth"
          protocol = "HTTPS"
          port     = 443
          hostname = "auth.law-orga.de"
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "lawandorga-backend-service-certificate"
              }
            ]
          }
        },
        {
          name     = "https-calendar"
          protocol = "HTTPS"
          port     = 443
          hostname = "calendar.law-orga.de"
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "lawandorga-backend-service-certificate"
              }
            ]
          }
        },
        {
          name     = "https-statistics"
          protocol = "HTTPS"
          port     = 443
          hostname = "statistics.law-orga.de"
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "lawandorga-statistics-frontend-certificate"
              }
            ]
          }
        },
        {
          name     = "https-chat"
          protocol = "HTTPS"
          port     = 443
          hostname = "chat.law-orga.de"
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "lawandorga-element-service-certificate"
              }
            ]
          }
          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
        }
        ,
        {
          name     = "https-synapse"
          protocol = "HTTPS"
          port     = 443
          hostname = "synapse.law-orga.de"
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "lawandorga-synapse-service-certificate"
              }
            ]
          }
          allowedRoutes = {
            namespaces = {
              from = "All"
            }
          }
        },
        {
          name     = "https-openproject"
          protocol = "HTTPS"
          port     = 443
          hostname = "openproject.law-orga.de"
          tls = {
            mode = "Terminate"
            certificateRefs = [
              {
                kind = "Secret"
                name = "openproject-certificate"
              }
            ]
          }
          allowedRoutes = {
            namespaces = {
              from = "All"
            }
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
