resource "google_project_service" "api_gateway" {
  service = "apigateway.googleapis.com"
}

resource "google_api_gateway_api" "bcx_api" {
  provider     = google-beta
  api_id       = "bcx-api-id"
  display_name = "API Gateway for Banchanxanh"
}

resource "google_api_gateway_api_config" "api_config" {
  provider  = google-beta
  api       = google_api_gateway_api.bcx_api.api_id
  
  openapi_documents {
    document {
      path     = var.openapi_file
      contents = base64encode(file(var.openapi_file))
    }
  }
}

resource "google_api_gateway_gateway" "api_gateway" {
  provider      = google-beta
  api_config    = google_api_gateway_api_config.api_config.id
  gateway_id    = "bcx-gateway"
  display_name  = "Ban Chan Xanh Gateway"
  region      = var.region
}