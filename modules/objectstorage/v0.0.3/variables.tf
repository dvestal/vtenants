variable "project" {
  description = "GCP project id"
  type        = string
}

variable "bucket_name" {
  description = "Name of the GCS bucket to create"
  type        = string
}

variable "location" {
  description = "Bucket location (e.g. US, EU, us-central1)"
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "GCS storage class"
  type        = string
  default     = "STANDARD"
}

variable "noncurrent_version_retention_days" {
  description = "Number of days to retain noncurrent (archived) object versions before deletion"
  type        = number
  default     = 90
}
