terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.13"
    }
  }
  backend "s3" {
    bucket                      = "lawandorga-main-infrastructure"
    key                         = "cluster.tfstate"
    region                      = "fr-par"
    endpoint                    = "https://s3.fr-par.scw.cloud"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
  required_version = ">= 1.0.0"
}
