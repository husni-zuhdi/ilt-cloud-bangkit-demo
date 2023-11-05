output "name" {
  description = "Name of Google Compute Engine"
  value       = module.fw.name
}

output "self_link" {
  description = "Self link URI of Google Compute Engine"
  value       = module.fw.self_link
}
