resource "google_project_service" "sqladmin" {
  service = "sqladmin.googleapis.com"
}

resource "google_sql_database_instance" "cloud_sql_instance" {
  name             = var.instance_name
  database_version = "POSTGRES_14" # Choose "POSTGRES_14" for PostgreSQL
  region           = var.region

  settings {
    tier = var.tier
    disk_size = var.disk_size
    activation_policy = "ALWAYS" # Keep the instance active
  }
}

resource "google_sql_user" "root_user" {
  instance = google_sql_database_instance.cloud_sql_instance.name
  name     = "root"
  password = var.root_password
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.cloud_sql_instance.name
}
