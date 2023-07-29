resource "google_compute_network" "vpc" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = false
  project                 = var.project
}

# Create a Subnet
resource "google_compute_subnetwork" "private" {
  name          = "${var.name}-subnet-private"
  ip_cidr_range = "10.10.0.0/24"
  network       = google_compute_network.vpc.name
  region        = var.region
}

resource "google_compute_subnetwork" "public" {
  name          = "${var.name}-subnet-public"
  ip_cidr_range = "10.20.0.0/24"
  network       = google_compute_network.vpc.name
  region        = var.region
}
