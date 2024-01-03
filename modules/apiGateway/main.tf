resource "google_api_gateway_api" "api_gw" {
  provider = google-beta
  api_id = var.api_id
}

resource "google_api_gateway_api_config" "api_gw" {
  provider             = google-beta
  api = google_api_gateway_api.api_gw.api_id
  api_config_id = var.api_config_id
  project      = var.project

  openapi_documents {
    document {
      path = var.path
      contents = filebase64("config/openapi.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [google_api_gateway_api.api_gw]
}

resource "google_api_gateway_gateway" "api_gw" {
  provider             = google-beta
  project      = var.project
  api_config = google_api_gateway_api_config.api_gw.id
  gateway_id = var.gateway_id
  depends_on = [google_api_gateway_api_config.api_gw]

}