resource "google_cloudfunctions_function" "function" {
  name                  = var.function_name
  project               = var.project
  region                = var.region
  runtime               = var.runtime
  entry_point           = var.entry_point
  available_memory_mb   = var.available_memory_mb
  timeout               = var.timeout
  source_archive_bucket = var.source_archive_bucket
  source_archive_object = var.source_archive_object

  #   https_trigger {}

  lifecycle {
    ignore_changes = [
      source_archive_bucket,
      source_archive_object,
    ]
  }

  labels = {
    managed_by = "terraform"
  }
}
