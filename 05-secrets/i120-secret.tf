resource "kubernetes_secret" "scaleway" {
  metadata {
    name      = "scaleway"
    namespace = "default"
  }

  data = {
    access-key = var.scw_access_key
    secret-key = var.scw_secret_key
    project-id = var.scw_project_id
  }

  type = "Opaque"
}
