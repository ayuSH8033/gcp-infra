
resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "subnet-1" {
  name          = var.subnet-1name
  ip_cidr_range = var.ip_cidr_range1
  network       = google_compute_network.vpc_network.id
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
  private_ipv6_google_access = "ENABLE_BIDIRECTIONAL_ACCESS_TO_GOOGLE"
  secondary_ip_range {
    range_name    = var.range_name1
    ip_cidr_range = var.ip_cidr_range2
  }
  secondary_ip_range {
    range_name    = var.range_name2
    ip_cidr_range = var.ip_cidr_range3
  }
  depends_on = [google_compute_network.vpc_network]
  private_ip_google_access = true
}
resource "google_compute_subnetwork" "subnet-2" {
  name          = var.subnet-2name
  ip_cidr_range = var.ip_cidr_range4
  network       = google_compute_network.vpc_network.id
  depends_on = [google_compute_network.vpc_network]
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
  private_ipv6_google_access = "ENABLE_BIDIRECTIONAL_ACCESS_TO_GOOGLE"
}
resource "google_compute_firewall" "allow-ssh" {
  name    = var.firewall_name1
  network = google_compute_network.vpc_network.id
  allow {
    protocol = var.protocol1
    ports    = var.ports1
  }
  source_ranges = var.source_ranges1
  depends_on = [google_compute_network.vpc_network]

}
resource "google_compute_firewall" "allow-internal" {
  name    = var.firewall_name2
  network = google_compute_network.vpc_network.id
  allow {
    protocol = var.protocol2
    ports    = var.ports2
  }
  allow {
  protocol = var.protocol3
    ports    = var.ports3
  }
   allow {
  protocol = var.protocol4
  }
  source_ranges = var.source_ranges2
  depends_on = [google_compute_network.vpc_network]
}