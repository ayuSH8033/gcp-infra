
resource "google_pubsub_topic" "example" {
  name = var.name
  labels = {
    foo = "bar"
  }
  message_retention_duration = var.time
}