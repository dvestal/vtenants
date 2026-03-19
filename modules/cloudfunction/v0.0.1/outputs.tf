output "function_name" {
  description = "Cloud Function name"
  value       = google_cloudfunctions_function.function.name
}

output "https_trigger_url" {
  description = "HTTPS trigger URL for the Cloud Function"
  value       = google_cloudfunctions_function.function.https_trigger_url
}

output "function_id" {
  description = "Cloud Function resource id"
  value       = google_cloudfunctions_function.function.id
}
