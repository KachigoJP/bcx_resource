resource "google_project_service" "api_gateway" {
  service = "apigateway.googleapis.com"
}

resource "google_api_gateway_api" "gateway_api" {
  api_id       = "bcx-api-id"
  display_name = "API Gateway for Kubernetes"
}

resource "google_api_gateway_api_config" "gateway_config" {
  api      = google_api_gateway_api.gateway_api.id
  config_id = "v1"
  
  openapi_documents {
    document {
      path     = var.openapi_file
      contents = file(var.openapi_file)
    }
  }
}

resource "google_api_gateway_gateway" "gateway" {
  api        = google_api_gateway_api.gateway_api.id
  gateway_id = "gcx-gateway-id"
  display_name = "Kubernetes API Gateway"
  location   = var.region
}
