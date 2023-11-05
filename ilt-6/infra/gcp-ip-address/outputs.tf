output "address" {
  description = "IP of External IP Address"
  value       = module.ip.address
}

output "self_link" {
  description = "Self link URI of External IP Address"
  value       = module.ip.self_link
}

