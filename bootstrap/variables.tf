variable "project" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "GCP region for the Artifact Registry repository"
  type        = string
  default     = "us-central1"
}

variable "repository_id" {
  description = "ID of the Artifact Registry repository"
  type        = string
  default     = "images"
}
