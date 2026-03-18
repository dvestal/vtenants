data "google_project" "current" {}

module "poseidon" {
  source = "git::https://github.com/dvestal/vplatform-apps.git//poseidon?ref=v0.0.1"

  project  = data.google_project.current.project_id
  location = "us-east1"
}

module "zeus" {
  source = "git::https://github.com/dvestal/vplatform-apps.git//zeus?ref=v0.0.1"

  project  = data.google_project.current.project_id
  location = "us-east1"
}
