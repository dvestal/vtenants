terraform {
  required_version = ">= 1.0"

  cloud {
    organization = "vestalconsulting"

    workspaces {
      name = "bootstrap"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}
