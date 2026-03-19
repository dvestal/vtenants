resource "google_artifact_registry_repository" "images" {
  project       = var.project
  location      = var.region
  repository_id = var.repository_id
  format        = "DOCKER"
  description   = "OCI image repository (managed by Terraform)"

  labels = {
    managed_by = "terraform"
  }
}
