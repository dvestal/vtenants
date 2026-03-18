terraform {
  required_version = ">= 1.0"

  cloud {
    organization = "vestalconsulting"

    workspaces {
      name = "client-one"
    }
  }
}

provider "google" {
  project = "avian-influence-490723-c6"
  region  = "us-east1"
}
