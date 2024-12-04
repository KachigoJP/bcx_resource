variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "database_name" {
  description = "Database name for Cloud SQL"
  type        = string
}

variable "instance_name" {
  description = "Cloud SQL instance name"
  type        = string
}

variable "root_password" {
  description = "Root password for the Cloud SQL instance"
  type        = string
}

variable "tier" {
  description = "Machine type for Cloud SQL instance"
  type        = string
}

variable "disk_size" {
  description = "Disk size in GB for Cloud SQL"
  type        = number
}
