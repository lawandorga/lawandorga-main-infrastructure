resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
  }
}

module "nginx-controller" {
  source    = "terraform-iaac/nginx-controller/helm"
  version   = "2.1.1"
  namespace = kubernetes_namespace.nginx.metadata.0.name

  # only specified because the default ones were already in use who knows why
  service_nodePort_http  = 32080
  service_nodePort_https = 32433

  # ip_address = "51.159.206.34"

  additional_set = []
}
