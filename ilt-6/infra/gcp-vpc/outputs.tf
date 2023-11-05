output "network_id" {
  value       = module.vpc.network_id
  description = "The ID of the VPC being created"
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The Self link URI of the VPC being created"
}

output "subnet_ip_range" {
  value       = module.vpc.subnet_ip_range
  description = "The name of the Subnet being created"
}

output "subnet_self_link" {
  value       = module.vpc.subnet_self_link
  description = "The Self link URI of the Subnet being created"
}

