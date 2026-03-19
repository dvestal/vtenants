terraform {
  required_version = ">= 1.0"

  cloud {
    organization = "vestalconsulting"

    workspaces {
      name = "vtenants-client-two"
    }
  }
}

provider "google" {
  project = "double-gamma-490622-n2"
  region  = "us-east1"
}
