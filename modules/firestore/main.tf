

resource "time_sleep" "wait_60_seconds" {

  create_duration = "60s"
}

resource "google_project_service" "firestore" {
  project = var.project
  service = var.service
  # Needed for CI tests for permissions to propagate, should not be needed for actual usage
  depends_on = [time_sleep.wait_60_seconds]
}

resource "google_firestore_database" "database" {
  project     = var.project
  name        = var.name
  location_id = var.region
  type        = "FIRESTORE_NATIVE"

  depends_on = [google_project_service.firestore]
}

resource "google_firestore_document" "mydoc" {
  project     = var.project
  collection  = var.collection
  document_id = var.document_id
  fields      = var.doc_fields
}