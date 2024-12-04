output "identity_platform" {
  value = module.identity_platform
}

output "api_gateway_url" {
  value = module.api_gateway.api_gateway_url
}

output "kubernetes_cluster" {
  value = module.kubernetes.cluster_endpoint
}

output "cloud_function_endpoint" {
  value = module.cloud_functions.function_endpoint
}
