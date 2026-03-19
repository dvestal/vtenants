variable "project" {
  description = "GCP project id"
  type        = string
}

variable "functionpackages_bucket_name" {
  description = "Name of the shared GCS bucket (from pegasus) used for Cloud Function source zip uploads"
  type        = string
}
