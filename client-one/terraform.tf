terraform {
  required_version = ">= 1.0"

  cloud {
    organization = "vestalconsulting"

    workspaces {
      name = "client-one"
    }
  }
}
