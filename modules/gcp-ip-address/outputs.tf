output "address" {
  description = "IP of External IP Address"
  value       = google_compute_address.ip.address
}

output "self_link" {
  description = "Self link URI of External IP Address"
  value       = google_compute_address.ip.self_link
}

