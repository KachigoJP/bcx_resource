output "kubernetes_cluster" {
  value = module.kubernetes.cluster_endpoint
}

output "vcp_network_id" {
  value = module.vpc.network_id
}

output "vcp_self_link" {
  value = module.vpc.self_link
}