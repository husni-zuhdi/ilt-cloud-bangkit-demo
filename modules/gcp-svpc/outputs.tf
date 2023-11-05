output "private_ip_self_link" {
  value       = google_compute_global_address.private_ip_alloc.self_link
  description = "The self link of created private ip range"
}

output "svpc_connector_name" {
  value       = google_vpc_access_connector.svpc_connector.name
  description = "The name of Serverless VPC Access Connector name"
}

output "svpc_connector_ip_range" {
  value       = google_vpc_access_connector.svpc_connector.ip_cidr_range
  description = "The ip range of Serverless VPC Access Connector name"
}

output "svpc_connector_status" {
  value       = google_vpc_access_connector.svpc_connector.state
  description = "The state of Serverless VPC Access Connector name"
}
