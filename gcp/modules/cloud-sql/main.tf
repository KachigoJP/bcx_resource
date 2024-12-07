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
  
    ip_configuration {
      ipv4_enabled = false # Disable Public IP
      private_network = var.vpc_id # Attach to VPC
    }
  }
}

resource "google_sql_user" "sql_user" {
  instance = google_sql_database_instance.cloud_sql_instance.name
  name     = var.db_username
  password = var.db_password
}