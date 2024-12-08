resource "google_project_service" "gke" {
  service = "container.googleapis.com"
}

resource "google_compute_subnetwork" "kubernetes_subnet" {
  name          = "kubernetes-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = var.vpc_id

  # Define secondary ranges for pods and services
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.1.0.0/20"  # Adjust size as needed
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.2.0.0/24"  # Adjust size as needed
  }
}

resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region
  initial_node_count = 1
  remove_default_node_pool = true

  networking_mode = "VPC_NATIVE"
  network         = var.vpc_self_link
  subnetwork      = google_compute_subnetwork.kubernetes_subnet.self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"  # Reserved for master nodes
  }

  master_authorized_networks_config {   # Enable and define authorized networks
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

  # node_config {
  #   machine_type = "e2-micro"
  #   disk_size_gb = var.disk_size
  #   disk_type    = "pd-ssd"
  # }
}

# data "google_container_cluster" "primary" {
#   name     = var.cluster_name
#   location = var.region
# }

# data "google_client_config" "default" {}

# provider "kubernetes" {
#   host                   = "https://${google_container_cluster.gke_cluster.endpoint}"
#   token                  = data.google_client_config.default.access_token
#   cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)

#   ignore_annotations = [
#     "^autopilot\\.gke\\.io\\/.*",
#     "^cloud\\.google\\.com\\/.*"
#   ]
# }


# Kubernetes ConfigMap for Non-Sensitive Data
# resource "kubernetes_config_map" "db_config" {
#   metadata {
#     name = "db-config"
#   }

#   data = {
#     DB_HOST = var.db_host
#   }
# }

# # Kubernetes Secret for Sensitive Data
# resource "kubernetes_secret" "db_credentials" {
#   metadata {
#     name = "db-credentials"
#   }

#   data = {
#     DB_USER     = base64encode(var.db_username)
#     DB_PASSWORD = base64encode(var.db_password)
#   }
# }


# Read and apply each YAML file as a kubernetes_manifest resource
# data "local_file" "yaml_files" {
#   for_each = fileset("${path.module}/config", "**/*.yaml")
#   filename = "${path.module}/config/${each.value}"
# }

# Apply YAML manifests to the Kubernetes cluster
# resource "kubernetes_manifest" "apply" {
#  for_each = {
#    for key, value in data.local_file.yaml_files :
#    key => yamldecode(value.content)
#  }
#  manifest = each.value
# }