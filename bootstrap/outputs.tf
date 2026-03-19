output "repository_id" {
  description = "Artifact Registry repository id"
  value       = google_artifact_registry_repository.images.repository_id
}

output "repository_url" {
  description = "Full OCI pull/push URL for the repository (REGION-docker.pkg.dev/PROJECT/REPO)"
  value       = "${var.region}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.images.repository_id}"
}
