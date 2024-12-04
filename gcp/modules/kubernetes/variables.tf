variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region for Kubernetes cluster"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}
