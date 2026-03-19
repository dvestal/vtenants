data "google_project" "current" {}

module "poseidon" {
  source = "git::https://github.com/dvestal/vplatform.git//applications/poseidon/v0.0.1"

  project = data.google_project.current.project_id
}
