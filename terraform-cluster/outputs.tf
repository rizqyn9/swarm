output "nat_ip" {
  value = google_compute_address.nat_ip.address
}

output "manager_ips" {
  value = google_compute_instance.manager[*].network_interface.0.access_config.0.nat_ip
}

output "worker_ips" {
  value = google_compute_instance.worker[*].network_interface.0.network_ip
}
