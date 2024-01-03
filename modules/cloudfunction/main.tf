

resource "random_id" "default" {
  byte_length = var.byte_length
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/viewer"
    members = [
      "user:var.user",
    ]
  }
}

resource "google_cloud_run_service_iam_binding" "binding" {
  location = var.region
  project = var.project
  service = google_cloud_run_service.default.name
  role = "roles/viewer"
  members = [
    "user:var.user",
  ]
  depends_on = [google_cloud_run_service.default]
}

resource "google_cloud_run_service_iam_member" "member" {
  location = var.region
  project = var.project
  service = google_cloud_run_service.default.name
  role = "roles/viewer"
  member = "user:var.user"
  depends_on = [google_cloud_run_service.default]
}

resource "google_cloud_run_service_iam_policy" "policy" {
  location = var.region
  project = var.project
  service = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.admin.policy_data
  depends_on = [google_cloud_run_service.default , data.google_iam_policy.admin]
}

resource "google_storage_bucket" "default" {
  name                        = "${random_id.default.hex}-gcp-source" # Every bucket name must be globally unique
  location                    = var.location
  uniform_bucket_level_access = true
  depends_on = [random_id.default]
  public_access_prevention = "enforced"
  logging {
    log_bucket = var.logging-bucket
  }
  versioning {
    enabled = true
  }
}

data "archive_file" "default" {
  type        = var.type
  output_path = var.output_path
  source_dir  = var.source_dir
}
resource "google_storage_bucket_object" "object" {
  name   = var.object_name
  bucket = google_storage_bucket.default.name
  source = data.archive_file.default.output_path # Add path to the zipped function source code
  depends_on = [data.archive_file.default]

}

resource "google_cloudfunctions2_function" "default" {
  name        = var.function_name
  location    = var.function_location

  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point 
    source {
      storage_source {
        bucket = google_storage_bucket.default.name
        object = google_storage_bucket_object.object.name
      }
    }
  }

  service_config {
    max_instance_count = var.max_instance_count
    available_memory   = var.available_memory
    timeout_seconds    = var.timeout_seconds
  }
    depends_on = [google_storage_bucket.default , google_storage_bucket_object.object]

}
resource "google_cloud_run_service" "default" {
  name     = var.cloud-run-name
  location = var.region

  template {
    spec {
      containers {
        image = var.image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}