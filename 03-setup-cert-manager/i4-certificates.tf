resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.11.0"
  namespace  = kubernetes_namespace.cert_manager.metadata.0.name

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "helm_release" "cert_manager_webhook_inwx" {
  name       = "cert-manager-webhook-inwx"
  repository = "https://smueller18.gitlab.io/helm-charts"
  chart      = "cert-manager-webhook-inwx"
  version    = "0.5.0"
  namespace  = kubernetes_namespace.cert_manager.metadata.0.name
  depends_on = [helm_release.cert_manager]
}

resource "kubernetes_manifest" "cert_issuer" {
  depends_on = [helm_release.cert_manager]
  manifest = yamldecode(templatefile(
    "${path.module}/i4.1-issuer.yml",
    {
      issuer_name = "${var.cluster_issuer_name}"
    }
  ))
}
