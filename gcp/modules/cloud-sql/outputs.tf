output "instance_name" {
  value = google_sql_database_instance.cloud_sql_instance.name
}

output "connection_name" {
  value = google_sql_database_instance.cloud_sql_instance.connection_name
}

output "instance_ip" {
  value = google_sql_database_instance.cloud_sql_instance.private_ip_address
}