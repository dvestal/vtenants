variable "project" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "GCP region for the Cloud SQL instance"
  type        = string
  default     = "us-central1"
}

variable "instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
}

variable "database_version" {
  description = "PostgreSQL version (e.g. POSTGRES_15, POSTGRES_14)"
  type        = string
  default     = "POSTGRES_15"
}

variable "tier" {
  description = "Machine tier for the Cloud SQL instance (e.g. db-f1-micro, db-custom-2-7680)"
  type        = string
  default     = "db-f1-micro"
}

variable "availability_type" {
  description = "Availability type: REGIONAL (HA) or ZONAL"
  type        = string
  default     = "ZONAL"
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 10
}

variable "ipv4_enabled" {
  description = "Whether the instance should be assigned a public IPv4 address"
  type        = bool
  default     = false
}

variable "private_network" {
  description = "VPC network self-link to attach the instance to for private IP access"
  type        = string
  default     = null
}

variable "database_name" {
  description = "Name of the default database to create inside the instance"
  type        = string
}

variable "database_user" {
  description = "Username for the default database user"
  type        = string
  default     = "app"
}

variable "database_password" {
  description = "Password for the default database user"
  type        = string
  sensitive   = true
}

variable "deletion_protection" {
  description = "Whether Terraform should prevent the instance from being deleted"
  type        = bool
  default     = true
}
