output "identity_platform" {
  value = module.identity_platform
}

output "api_gateway_url" {
  value = module.api_gateway.api_gateway_url
}

output "kubernetes_cluster" {
  value = module.kubernetes.cluster_endpoint
}

output "cloud_sql_instance" {
  value = module.cloud_sql.instance_name
}

output "cloud_sql_connection_name" {
  value = module.cloud_sql.connection_name
}