output "service_name" {
  value       = google_cloud_run_service.main.name
  description = "Name of the created service"
}

output "revision" {
  value       = google_cloud_run_service.main.status[0].latest_ready_revision_name
  description = "Deployed revision for the service"
}

output "service_url" {
  value       = google_cloud_run_service.main.status[0].url
  description = "The URL on which the deployed service is available"
}

output "project_id" {
  value       = google_cloud_run_service.main.project
  description = "Google Cloud project in which the service was created"
}

output "location" {
  value       = google_cloud_run_service.main.location
  description = "Location in which the Cloud Run service was created"
}

output "service_id" {
  value       = google_cloud_run_service.main.id
  description = "Unique Identifier for the created service"
}

output "service_status" {
  value       = google_cloud_run_service.main.status[0].conditions[0].type
  description = "Status of the created service"
}

output "domain_map_id" {
  value       = values(google_cloud_run_domain_mapping.domain_map)[*].id
  description = "Unique Identifier for the created domain map"
}

output "domain_map_status" {
  value       = values(google_cloud_run_domain_mapping.domain_map)[*].status
  description = "Status of Domain mapping"
}

output "verified_domain_name" {
  value       = values(google_cloud_run_domain_mapping.domain_map)[*].name
  description = "List of Custom Domain Name"
}

