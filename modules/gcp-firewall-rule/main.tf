resource "google_compute_firewall" "fw" {
  name    = var.name
  network = var.network_self_link
  project = var.project_id

  allow {
    protocol = var.protocol
    ports    = var.ports
  }
  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}
