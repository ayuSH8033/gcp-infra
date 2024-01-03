provider "google-beta" {
  credentials = var.google_credentials
  project     = var.project
  region      = var.region
}