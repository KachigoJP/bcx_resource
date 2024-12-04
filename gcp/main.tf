module "identity_platform" {
  source = "./modules/identity-platform"
  project_id = var.project_id
  region     = var.region
}

module "api_gateway" {
  source        = "./modules/api-gateway"
  project_id    = var.project_id
  region        = var.region
  openapi_file  = var.openapi_file
}

module "kubernetes" {
  source      = "./modules/kubernetes"
  project_id  = var.project_id
  region      = var.region
  cluster_name = var.cluster_name
}

module "cloud_functions" {
  source         = "./modules/cloud-functions"
  project_id     = var.project_id
  region         = var.region
  bucket_name    = var.bucket_name
  function_name  = var.function_name
  source_archive = var.source_archive
}
