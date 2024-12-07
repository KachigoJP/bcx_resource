

module "vpc" {
  source      = "./modules/vpc"
  region        = var.region
}

module "identity_platform" {
  source = "./modules/identity-platform"
  project_id = var.project_id
}

module "api_gateway" {
  source        = "./modules/api-gateway"
  project_id    = var.project_id
  region        = var.region
  openapi_file  = var.openapi_file
  vpc_id        = module.vpc.network_id   # Pass VPC ID from VPC module
  vpc_self_link = module.vpc.self_link
}

module "cloud_sql" {
  source            = "./modules/cloud-sql"
  project_id        = var.project_id
  region            = var.region
  db_instance_name  = var.db_instance_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_disk_size      = var.db_disk_size
  vpc_id            = module.vpc.network_id
}

module "kubernetes" {
  source          = "./modules/kubernetes"
  project_id      = var.project_id
  region          = var.region
  cluster_name    = var.cluster_name
  vpc_id          = module.vpc.network_id
  vpc_self_link   = module.vpc.self_link
  disk_size       = var.k8s_disk_size
  db_host         = module.cloud_sql.instance_ip
  db_username     = var.db_username
  db_password     = var.db_password
}
