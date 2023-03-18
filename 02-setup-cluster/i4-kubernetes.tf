provider "kubernetes" {
  host                   = scaleway_k8s_cluster.cluster.kubeconfig.0.host
  token                  = scaleway_k8s_cluster.cluster.kubeconfig.0.token
  cluster_ca_certificate = base64decode(scaleway_k8s_cluster.cluster.kubeconfig.0.cluster_ca_certificate)
}

resource "kubernetes_secret" "image_pull_secret" {
  type = "kubernetes.io/dockerconfigjson"

  metadata {
    name      = "image-pull-secret"
    namespace = "default"
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${scaleway_registry_namespace.registry.endpoint}" = {
          username = "${scaleway_registry_namespace.registry.name}"
          password = "${var.scw_secret_key}"
        }
      }
    })
  }
}
