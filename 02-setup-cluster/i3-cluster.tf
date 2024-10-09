resource "scaleway_vpc_private_network" "vpc" {
  name = "kapsule-20240502"
  tags = []
}

resource "scaleway_k8s_cluster" "cluster" {
  private_network_id          = scaleway_vpc_private_network.vpc.id
  name                        = "lawandorga_cluster"
  version                     = "1.26.0"
  cni                         = "cilium"
  delete_additional_resources = false
  type                        = "kapsule"
}

resource "scaleway_k8s_pool" "pool" {
  cluster_id  = scaleway_k8s_cluster.cluster.id
  name        = "lawandorga_pool"
  node_type   = "DEV1-XL"
  size        = 1
  min_size    = 1
  max_size    = 2
  autoscaling = true
  autohealing = true
}

resource "scaleway_registry_namespace" "registry" {
  name      = "lawandorga-registry"
  is_public = false
}
