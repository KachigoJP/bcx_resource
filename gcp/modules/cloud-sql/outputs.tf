output "instance_name" {
  value = google_sql_database_instance.cloud_sql_instance.name
}

output "database_name" {
  value = google_sql_database.database.name
}
