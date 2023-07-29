resource "google_compute_address" "nat_ip" {
  name   = "${var.name}nat-ip"
  region = var.region
}

data "google_compute_address" "nat_ip" {
  name = "devnat-ip"
}

output "nat" {
  value = data.google_compute_address.nat_ip.address
}

## Create Cloud Router
resource "google_compute_router" "router" {
  name    = "nat-router"
  project = var.project
  network = google_compute_network.vpc.name
  region  = var.region
}


## Create Nat Gateway
resource "google_compute_router_nat" "nat" {
  name   = "${var.name}-nat-gateway"
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = [google_compute_address.nat_ip.self_link]

  # source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
