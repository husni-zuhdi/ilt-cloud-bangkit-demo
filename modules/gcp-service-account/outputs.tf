output "service_account" {
  description = "Service account resource (for single use)."
  value       = try(local.service_accounts_list[0], null)
}

output "email" {
  description = "Service account email (for single use)."
  value       = try(local.emails_list[0], null)
}

output "iam_email" {
  description = "IAM-format service account email (for single use)."
  value       = try(local.iam_emails_list[0], null)
}

output "key" {
  description = "Service account key (for single use)."
  sensitive   = true
  value       = var.generate_keys ? base64decode(google_service_account_key.keys[var.names[0]].private_key) : ""
}

output "service_accounts" {
  description = "Service account resources as list."
  value       = local.service_accounts_list
}

output "service_accounts_map" {
  description = "Service account resources by name."
  value       = google_service_account.service_accounts
}

output "emails" {
  description = "Service account emails by name."
  value       = zipmap(local.service_accounts_list[*].name, local.emails_list)
}

output "iam_emails" {
  description = "IAM-format service account emails by name."
  value       = zipmap(local.service_accounts_list[*].name, local.iam_emails_list)
}

output "emails_list" {
  description = "Service account emails as list."
  value       = local.emails_list
}

output "iam_emails_list" {
  description = "IAM-format service account emails as list."
  value       = local.iam_emails_list
}

output "keys" {
  description = "Map of service account keys."
  sensitive   = true
  value       = { for k, v in local.names : k => var.generate_keys ? base64decode(google_service_account_key.keys[v].private_key) : "" }
}
