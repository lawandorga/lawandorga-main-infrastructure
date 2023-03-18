resource "kubernetes_secret_v1" "inwx_credentials" {
  metadata {
    name      = "inwx-credentials"
    namespace = "cert-manager"
  }

  data = {
    username = "${var.inwx_username}"
    password = "${var.inwx_password}"
  }

  type = "Opaque"
}
