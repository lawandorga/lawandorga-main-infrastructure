output "cluster_id" {
  value = scaleway_k8s_cluster.cluster.id
}

output "cluster_name" {
  value = scaleway_k8s_cluster.cluster.name
}

output "registry_name" {
  value = scaleway_registry_namespace.registry.name
}

output "registry_endpoint" {
  value = scaleway_registry_namespace.registry.endpoint
}

output "image_pull_secret_name" {
  value = kubernetes_secret.image_pull_secret.metadata.0.name
}
