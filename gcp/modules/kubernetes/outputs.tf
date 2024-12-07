output "cluster_endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
}

output "cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "master_auth" {
  value = google_container_cluster.gke_cluster.master_auth
}