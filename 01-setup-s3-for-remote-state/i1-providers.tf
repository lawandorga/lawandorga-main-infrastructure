terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.13"
    }
  }
  required_version = ">= 1.0.0"
}

provider "scaleway" {
  access_key = var.scw_access_key
  secret_key = var.scw_secret_key
  project_id = var.scw_project_id
  zone       = "fr-par-1"
  region     = "fr-par"
}