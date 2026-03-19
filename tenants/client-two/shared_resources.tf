data "google_project" "current" {}

module "pegasus" {
  source = "../../applications/pegasus/v0.0.1"

  project = data.google_project.current.project_id
}

module "poseidon" {
  source = "../../applications/poseidon/v0.0.1"

  project = data.google_project.current.project_id
}

module "zeus" {
  source = "../../applications/zeus/v0.0.3"

  project                      = data.google_project.current.project_id
  functionpackages_bucket_name = module.pegasus.functionpackages_bucket_name
}
