output "name" {
  description = "Name of Firewall Rule"
  value       = google_compute_firewall.fw.name
}

output "self_link" {
  description = "Self link URI of Firewall Rule"
  value       = google_compute_firewall.fw.self_link
}

