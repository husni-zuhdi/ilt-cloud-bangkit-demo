output "name" {
  description = "Name of Google Compute Engine"
  value       = google_compute_instance.gce.name
}

output "self_link" {
  description = "Self link URI of Google Compute Engine"
  value       = google_compute_instance.gce.self_link
}

output "network_interface" {
  description = "Network Interface of Google Compute Engine"
  value       = google_compute_instance.gce.network_interface
}

