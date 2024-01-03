provider "google" {
  project     = var.project
  region      = var.region
  credentials = var.google_credentials
}