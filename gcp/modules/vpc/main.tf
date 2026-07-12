resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false # Disable auto subnet creation
}

# Create subnets for the VPC
resource "google_compute_router" "router" {
  name    = "bcx-kubernetes-router"
  network = google_compute_network.vpc_network.id
  region  = var.region
}

resource "google_compute_global_address" "service_range" {
  name          = "google-managed-services"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16 # Adjust this as needed (e.g., /20, /24).
  network       = google_compute_network.vpc_network.name
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.service_range.name]
}