resource "google_project_service" "gke" {
  service = "container.googleapis.com"
}

resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region
  autopilot = true

  # Use a single node to stay within the free tier
  node_config {
    machine_type = "e2-micro" # Free tier eligible
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
    ]
  }

  initial_node_count = 1
}
