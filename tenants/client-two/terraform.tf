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
  project = "avian-influence-490723-c6"
  region  = "us-east1"
}
