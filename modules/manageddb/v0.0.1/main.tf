resource "google_sql_database_instance" "postgres" {
  name             = var.instance_name
  project          = var.project
  region           = var.region
  database_version = var.database_version

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_type         = "PD_SSD"

    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = var.private_network
    }

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
    }

    maintenance_window {
      day          = 7 # Sunday
      hour         = 4
      update_track = "stable"
    }

    database_flags {
      name  = "log_connections"
      value = "on"
    }

    user_labels = {
      managed_by = "terraform"
    }
  }

  deletion_protection = var.deletion_protection
}

resource "google_sql_database" "default" {
  name     = var.database_name
  project  = var.project
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "default" {
  name     = var.database_user
  project  = var.project
  instance = google_sql_database_instance.postgres.name
  password = var.database_password
}
