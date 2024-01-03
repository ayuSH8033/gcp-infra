
resource "google_storage_bucket" "static-site" {
  name          = var.name
  location      = var.region
  force_destroy = true
    versioning {
    enabled = true
  }
  logging {
    log_bucket = var.logging-bucket
  }
  uniform_bucket_level_access = true
  public_access_prevention = "enforced"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}