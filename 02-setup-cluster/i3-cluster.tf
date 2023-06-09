resource "scaleway_k8s_cluster" "cluster" {
  name                        = "lawandorga_cluster"
  version                     = "1.26.0"
  cni                         = "cilium"
  delete_additional_resources = false
  type                        = "kapsule"
}

resource "scaleway_k8s_pool" "pool" {
  cluster_id = scaleway_k8s_cluster.cluster.id
  name       = "lawandorga_pool"
  node_type  = "DEV1-XL"
  size       = 1
}

resource "scaleway_registry_namespace" "registry" {
  name      = "lawandorga-registry"
  is_public = false
}
