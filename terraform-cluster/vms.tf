locals {
  ssh_keys = "${var.user}:${file(var.publicKeyPath)}"
}

resource "google_compute_instance" "manager" {
  count        = var.manager_count
  name         = "${var.name}-manager-${count.index}"
  machine_type = var.manager_instance_type
  zone         = var.zone

  allow_stopping_for_update = true

  metadata = {
    ssh-keys = local.ssh_keys
  }

  boot_disk {
    initialize_params {
      image = var.machine_image
      size  = var.root_block_device_size
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.public.name

    access_config {
      // Leave empty to get an ephemeral public IP
    }
  }

  service_account {
    # https://developers.google.com/identity/protocols/googlescopes
    scopes = [
      "https://www.googleapis.com/auth/compute.readonly",
      "https://www.googleapis.com/auth/logging.write",
    ]
  }
}

resource "google_compute_instance" "worker" {
  count        = var.worker_count
  name         = "${var.name}-worker-${count.index}"
  machine_type = var.worker_instance_type
  zone         = var.zone

  allow_stopping_for_update = true

  metadata = {
    ssh-keys = local.ssh_keys
  }

  boot_disk {
    initialize_params {
      image = var.machine_image
      size  = var.root_block_device_size
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.private.name
  }

  service_account {
    # https://developers.google.com/identity/protocols/googlescopes
    scopes = [
      "https://www.googleapis.com/auth/compute.readonly",
      "https://www.googleapis.com/auth/logging.write",
    ]
  }
}
