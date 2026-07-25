variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "banchanxanh"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "cluster_location" {
  description = "GKE cluster location. Use us-central1-a for a zonal Standard cluster eligible for GKE free-tier cluster credit."
  type        = string
  default     = "us-central1-a"
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

variable "db_disk_size" {
  description = "Disk size in GB for Cloud SQL"
  type        = number
  default     = 10 # Free-tier eligible
}

variable "k8s_disk_size" {
  description = "Disk size in GB for Kubernetes"
  type        = number
  default     = 100 # Free-tier eligible
}

variable "k8s_node_machine_type" {
  description = "Machine type for the primary GKE node pool"
  type        = string
  default     = "e2-standard-2"
}

variable "k8s_node_disk_type" {
  description = "Boot disk type for each GKE node"
  type        = string
  default     = "pd-standard"
}

variable "k8s_node_locations" {
  description = "Additional zones where GKE nodes should run. Leave empty for a single-zone cluster."
  type        = list(string)
  default     = []
}

variable "network_name" {
  description = "GCP project Network name"
  type        = string
  default     = "bcx-kubernetes-vpc"
}
