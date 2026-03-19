output "functionpackages_bucket_name" {
  description = "Name of the GCS bucket used for Cloud Function source zip uploads"
  value       = module.functionpackages.bucket_name
}

output "functionpackages_bucket_url" {
  description = "GCS URL of the Cloud Function packages bucket"
  value       = module.functionpackages.bucket_url
}
