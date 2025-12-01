output "external_secrets_namespace" {
  description = "the namespace where external secrets is deployed"
  value       = kubernetes_namespace.external_secrets.metadata[0].name
}

output "scaleway_cluster_secret_store_name" {
  description = "the name of the scaleway cluster secret store"
  value       = kubernetes_manifest.scaleway_cluster_secret_store.manifest["metadata"]["name"]
}
