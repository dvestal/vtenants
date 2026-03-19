variable "project" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "GCP region for the Cloud Function"
  type        = string
  default     = "us-central1"
}

variable "function_name" {
  description = "Name of the Cloud Function to create"
  type        = string
}

variable "runtime" {
  description = "Function runtime (e.g. python39, nodejs18)"
  type        = string
  default     = "python39"
}

variable "entry_point" {
  description = "Function entry point"
  type        = string
  default     = "handler"
}

variable "source_archive_bucket" {
  description = "GCS bucket that contains the function source zip"
  type        = string
}

variable "source_archive_object" {
  description = "GCS object (zip) name containing function source"
  type        = string
}

variable "available_memory_mb" {
  description = "Memory for the function in MB"
  type        = number
  default     = 256
}

variable "timeout" {
  description = "Function timeout in seconds"
  type        = number
  default     = 60
}
