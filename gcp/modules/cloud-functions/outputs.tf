output "function_endpoint" {
  value = google_cloudfunctions_function.crud_function.https_trigger_url
}
