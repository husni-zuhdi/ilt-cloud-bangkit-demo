output "name" {
  description = "Name of Google Compute Engine"
  value       = module.gce.name
}

output "self_link" {
  description = "Self link URI of Google Compute Engine"
  value       = module.gce.self_link
}

output "network_interface" {
  description = "Network Interface of Google Compute Engine"
  value       = module.gce.network_interface
}
