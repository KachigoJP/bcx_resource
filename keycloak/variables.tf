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

variable "db_connection_name" {
  description = "Cloud SQL connection name"
  type        = string
}

variable "keycloak_password" {
  description = "Root password for the Cloud SQL instance"
  type        = string
  sensivite   = true
}