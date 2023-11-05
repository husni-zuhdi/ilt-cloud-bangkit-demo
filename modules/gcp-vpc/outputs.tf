output "network_name" {
  value       = google_compute_network.vpc_network.name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = google_compute_network.vpc_network.id
  description = "The ID of the VPC being created"
}

output "network_self_link" {
  value       = google_compute_network.vpc_network.self_link
  description = "The URI of the VPC being created"
}

output "subnet_ip_range" {
  value       = google_compute_subnetwork.vpc_subnetwork.name
  description = "The IP range of created subnet"
}

output "subnet_self_link" {
  value       = google_compute_subnetwork.vpc_subnetwork.self_link
  description = "The self link of created subnet"
}
