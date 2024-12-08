resource "google_project_service" "sqladmin" {
  service = "sqladmin.googleapis.com"
}

resource "google_sql_database_instance" "cloud_sql_instance" {
  name             = var.db_instance_name
  database_version = "POSTGRES_14"
  region           = var.region

  settings {
    tier              = "db-f1-micro" # Free tier eligible
    disk_size         = var.db_disk_size # Free tier allows up to 10GB
    activation_policy = "ALWAYS" # Keep the instance active
    # storage_auto_resize = false # Avoid extra charges from resizing
    backup_configuration {
      enabled = false # Disable backups to avoid storage charges
    }

    database_flags {
      name  = "log_statement"
      value = "all"
    }

    database_flags {
      name  = "log_min_duration_statement"
      value = "1000" # Logs queries taking longer than 1000 ms
    }
  
    ip_configuration {
      ipv4_enabled = false # Disable Public IP
      private_network = "projects/${var.project_id}/global/networks/${var.network_name}"
    }
  }
}

resource "google_sql_user" "sql_user" {
  instance = google_sql_database_instance.cloud_sql_instance.name
  name     = var.db_username
  password = var.db_password
}