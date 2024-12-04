output "api_gateway_url" {
  value = google_api_gateway_gateway.gateway.default_hostname
}
