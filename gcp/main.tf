module "vpc" {
  source       = "./modules/vpc"
  region       = var.region
  network_name = var.network_name
}

module "kubernetes" {
  source            = "./modules/kubernetes"
  project_id        = var.project_id
  region            = var.region
  cluster_location  = var.cluster_location
  cluster_name      = var.cluster_name
  vpc_id            = module.vpc.network_id
  vpc_self_link     = module.vpc.self_link
  disk_size         = var.k8s_disk_size
  node_machine_type = var.k8s_node_machine_type
  node_disk_type    = var.k8s_node_disk_type
  node_locations    = var.k8s_node_locations
}
