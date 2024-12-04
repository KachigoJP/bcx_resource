resource "google_project_service" "cloud_functions" {
  service = "cloudfunctions.googleapis.com"
}

resource "google_storage_bucket" "functions_bucket" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true
}

resource "google_cloudfunctions_function" "crud_function" {
  name        = var.function_name
  runtime     = "nodejs18" # Free-tier eligible runtime
  source_archive_bucket = google_storage_bucket.functions_bucket.name
  source_archive_object = var.source_archive
  trigger_http = true
  entry_point  = "main"
}
