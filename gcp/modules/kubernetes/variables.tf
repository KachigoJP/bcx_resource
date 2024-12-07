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

variable "disk_size" {
  description = "Size of Dict for 1 Node"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC network"
  type        = string
}

variable "vpc_self_link" {
  description = "Self link of the VPC network"
  type        = string
}


variable "db_host" {
  description = "Host of Database"
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
