variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "openapi_file" {
  description = "Path to OpenAPI specification file"
  type        = string
}

variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "microservices-cluster"
}

variable "bucket_name" {
  description = "Cloud Functions storage bucket name"
  type        = string
}

variable "function_name" {
  description = "Cloud Function name"
  type        = string
}

variable "source_archive" {
  description = "Path to the Cloud Function source archive"
  type        = string
}
