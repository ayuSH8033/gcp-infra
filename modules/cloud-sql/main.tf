
resource "google_sql_database_instance" "master" {
name = var.instance_name
database_version = var.db_version
region = var.region
settings {
  tier = var.db_tier
  ip_configuration {
        require_ssl = true
        ipv4_enabled = false
    }
    backup_configuration {
        enabled = true
        binary_log_enabled             = true
      start_time                     = "20:55"
      transaction_log_retention_days = "3"
    }
}
  deletion_protection = false

}
resource "google_sql_database" "database" {
name = var.database_name
instance = google_sql_database_instance.master.name
charset = "utf8"
collation = "utf8_general_ci"
}
resource "google_sql_user" "users" {
name = var.user
instance = google_sql_database_instance.master.name
host = "%"
password = "XXXXXXXXX"
}