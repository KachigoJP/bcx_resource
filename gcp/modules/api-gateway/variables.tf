variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region for API Gateway"
  type        = string
}

variable "openapi_file" {
  description = "Path to OpenAPI specification file"
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
