

  zone        = "europe-west1-c"
  net_name    = "second-testing-net"
  source_ranges = ["203.129.220.230"]
  name = "second-testing-vm"
  firewall-name = "second-testing-firewall"
  machine_type = "e2-micro"
  protocol = "tcp"
  ports    = ["22","443","80","8080","3306"]
  subnet_name = "second-testing-subnet"
  ip_cidr_range = "10.0.0.0/8"
  image = "ubuntu-os-cloud/ubuntu-2004-focal-v20220712"
  ip_condition = false
  os_login = true
  serial_port_condition = false
  project     = "infra-testing-2023"
  region                =  "europe-west1"
  google_credentials = "xyz.json"