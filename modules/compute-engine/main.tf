

resource "google_compute_instance" "default" {
  name = var.name
  zone = var.zone
  machine_type = var.machine_type
  can_ip_forward = var.ip_condition
  network_interface {
    network = google_compute_network.ipv6net.id
    subnetwork = google_compute_subnetwork.ipv6subnet.id
    stack_type = "IPV4_IPV6"
    access_config {
      network_tier = "PREMIUM"

    }

    ipv6_access_config {
      network_tier  = "PREMIUM"
    }


  }
  metadata = {
  enable-oslogin = var.os_login
  serial-port-enable = var.serial_port_condition
  block-project-ssh-keys = true
  }

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  # Some changes require full VM restarts
  # consider disabling this flag in production
  #   depending on your needs
  allow_stopping_for_update = true
  shielded_instance_config {
         enable_integrity_monitoring = true
         enable_vtpm                 = true
        }
depends_on = [google_compute_network.ipv6net, google_compute_subnetwork.ipv6subnet]

}
 # Create a network
resource "google_compute_network" "ipv6net" {
  name = var.net_name
  auto_create_subnetworks = false
}

# Create a subnet with IPv6 capabilities
resource "google_compute_subnetwork" "ipv6subnet" {
  name = var.subnet_name
  network = google_compute_network.ipv6net.id
  ip_cidr_range = var.ip_cidr_range
  stack_type = "IPV4_IPV6"
  ipv6_access_type = "EXTERNAL"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
# Allow SSH from all IPs (insecure, but ok for this tutorial)
resource "google_compute_firewall" "firewall" {
  name    = var.firewall-name
  network = google_compute_network.ipv6net.name


  source_ranges = var.source_ranges
  allow {
    protocol = var.protocol
    ports    = var.ports
  }


  depends_on = [google_compute_network.ipv6net]
 
}

  
