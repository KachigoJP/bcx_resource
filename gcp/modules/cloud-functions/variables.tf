variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region for Cloud Functions"
  type        = string
}

variable "bucket_name" {
  description = "Cloud Functions bucket name"
  type        = string
}

variable "function_name" {
  description = "Cloud Function name"
  type        = string
}

variable "source_archive" {
  description = "Source archive for Cloud Function"
  type        = string
}
