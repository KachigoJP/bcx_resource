variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region for Kubernetes cluster"
  type        = string
}

variable "cluster_location" {
  description = "GKE cluster location. Use a zone like us-central1-a for a zonal Standard cluster."
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "bcx-cluster"
}

variable "disk_size" {
  description = "Boot disk size in GB for each GKE node"
  type        = number
  default     = 10
}

variable "vpc_id" {
  description = "ID of the VPC network"
  type        = string
}

variable "vpc_self_link" {
  description = "Self link of the VPC network"
  type        = string
}

variable "node_machine_type" {
  description = "Machine type for the primary node pool"
  type        = string
  default     = "e2-standard-2"
}

variable "node_disk_type" {
  description = "Boot disk type for each GKE node"
  type        = string
  default     = "pd-standard"
}

variable "node_locations" {
  description = "Additional zones where GKE nodes should run. Leave empty for a single-zone cluster."
  type        = list(string)
  default     = []
}
