resource "google_vertex_ai_endpoint" "endpoint" {
  name = var.name
  display_name = var.display_name
  project      = var.project
  location     = var.region
}

resource "google_vertex_ai_dataset" "dataset" {
  display_name          = var.model_name
  metadata_schema_uri   = var.image_uri
  region                = var.region

  labels = {
    env = "test"
  }
  encryption_spec {
       kms_key_name=google_kms_crypto_key.example.name
     }
}
resource "google_kms_key_ring" "keyring" {
  name     = var.name
  location = var.region
}

resource "google_kms_crypto_key" "example-key" {
  name            = var.key-name
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = var.rotation_period

  lifecycle {
    prevent_destroy = true
  }
  depends_on = [google_kms_key_ring.keyring]
}




