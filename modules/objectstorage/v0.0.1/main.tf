resource "google_storage_bucket" "object" {
  name          = var.bucket_name
  project       = var.project
  location      = var.location
  storage_class = var.storage_class

  labels = {
    managed_by = "terraform"
  }
}
