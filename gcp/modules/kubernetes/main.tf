resource "google_project_service" "gke" {
  service = "container.googleapis.com"
}

resource "google_compute_subnetwork" "kubernetes_subnet" {
  name          = "kubernetes-subnet"
  ip_cidr_range = "10.10.0.0/16"
  region        = var.region
  network       = var.vpc_id

  # Define secondary ranges for pods and services
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.11.0.0/20" # Adjust size as needed
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.12.0.0/24" # Adjust size as needed
  }
}

resource "google_container_cluster" "gke_cluster" {
  name                     = var.cluster_name
  location                 = var.cluster_location
  node_locations           = var.node_locations
  initial_node_count       = 1
  remove_default_node_pool = true

  networking_mode = "VPC_NATIVE"
  network         = var.vpc_self_link
  subnetwork      = google_compute_subnetwork.kubernetes_subnet.self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = false
  }

  master_authorized_networks_config { # Enable and define authorized networks
    cidr_blocks {
      cidr_block   = "10.239.0.0/24"
      display_name = "GCP Network"
    }
  }

  addons_config {
    network_policy_config {
      disabled = false
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-primary-pool"
  location   = var.cluster_location
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  network_config {
    enable_private_nodes = false
  }

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = var.disk_size
    disk_type    = var.node_disk_type
    image_type   = "COS_CONTAINERD"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      cluster = var.cluster_name
    }
  }
}
