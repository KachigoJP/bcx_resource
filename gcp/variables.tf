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
  default     = "bcx-cluster"
}

variable "db_instance_name" {
  description = "Cloud SQL instance name"
  type        = string
  default     = "bcx-sql-instance"
}

variable "db_username" {
  description = "Username for the Cloud SQL instance"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for the Cloud SQL instance"
  type        = string
  sensitive   = true
}

variable "db_disk_size" {
  description = "Disk size in GB for Cloud SQL"
  type        = number
  default     = 10 # Free-tier eligible
}


variable "k8s_disk_size" {
  description = "Disk size in GB for Kubernetes"
  type        = number
  default     = 10 # Free-tier eligible
}
