resource "google_kms_key_ring" "keyring" {
  name     = var.new-name
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