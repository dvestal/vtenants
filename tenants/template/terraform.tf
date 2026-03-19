terraform {
  required_version = ">= 1.0"

  cloud {
    organization = "vestalconsulting"

    workspaces {
      name = "template"
    }
  }
}

provider "google" {
  project = "CONFIGURE_ME"
  region  = "us-east1"
}
