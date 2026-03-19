resource "google_storage_bucket" "object" {
  name          = var.bucket_name
  project       = var.project
  location      = var.location
  storage_class = var.storage_class

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  labels = {
    managed_by = "terraform"
  }
}
