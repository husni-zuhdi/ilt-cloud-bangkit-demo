output "svpc_connector_name" {
  value       = module.vpc.svpc_connector_name
  description = "The name of Serverless VPC Access Connector name"
}

output "svpc_connector_status" {
  value       = module.vpc.svpc_connector_status
  description = "The status of Serverless VPC Access Connector name"
}
