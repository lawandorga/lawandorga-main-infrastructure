variable "inwx_username" {
  type = string
}

variable "inwx_password" {
  type = string
}

variable "cluster_issuer_name" {
  type    = string
  default = "cluster-issuer"
}

variable "scw_secret_key" {
  type = string
}

variable "scw_access_key" {
  type = string
}

variable "scw_project_id" {
  type = string
}
