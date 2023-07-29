resource "google_compute_firewall" "swarm_manager" {
  name          = "${var.name}-swarm-manager"
  network       = google_compute_network.vpc.id
  source_ranges = [var.allowlist_ip]

  allow {
    protocol = "tcp"
    ports    = [80, 2375, 3375, 3376]
  }
}

resource "google_compute_firewall" "swarm_node" {
  name          = "${var.name}-swarm-node"
  network       = google_compute_network.vpc.id
  source_ranges = [var.allowlist_ip]

  allow {
    protocol = "tcp"
    ports    = [80, 2375, 2376]
  }
}

resource "google_compute_firewall" "ssh_ingress" {
  name          = "${var.name}-ssh-ingress"
  network       = google_compute_network.vpc.name
  source_ranges = [var.allowlist_ip]
  priority      = 1

  # SSH
  allow {
    protocol = "tcp"
    ports    = [22]
  }
}

resource "google_compute_firewall" "swarm_ingress" {
  name          = "${var.name}-swarm-ingress"
  network       = google_compute_network.vpc.id
  source_ranges = [var.allowlist_ip]
  priority      = 10

  allow {
    protocol = "tcp"
    ports    = [7946]
  }

  allow {
    protocol = "udp"
    ports    = [7946, 4789]
  }
}


resource "google_compute_firewall" "allow_all_internal" {
  name          = "${var.name}-allow-all-internal"
  network       = google_compute_network.vpc.name
  priority      = 1
  source_ranges = [var.allowlist_ip]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
}
