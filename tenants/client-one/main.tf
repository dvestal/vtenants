data "google_project" "current" {}

module "poseidon" {
  source = "../../applications/poseidon/v0.0.2"

  project = data.google_project.current.project_id
}
