variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "db_instance_name" {
  description = "Cloud SQL instance name"
  type        = string
}

variable "db_username" {
  description = "Root username for the Cloud SQL instance"
  type        = string
}

variable "db_password" {
  description = "Root password for the Cloud SQL instance"
  type        = string
}

variable "db_disk_size" {
  description = "Disk size in GB for Cloud SQL"
  type        = number
}

variable "network_name" {
  description = "GCP project Network name"
  type        = string
}