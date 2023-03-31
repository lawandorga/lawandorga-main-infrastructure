variable "cluster_issuer_name" {
  type    = string
  default = "cluster-issuer"
}

variable "scw_secret_key" {
  type      = string
  sensitive = true
}

variable "scw_access_key" {
  type      = string
  sensitive = true
}

variable "scw_project_id" {
  type      = string
  sensitive = true
}

