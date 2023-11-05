locals {
  names = ["${var.ilt_name}-service-account"]
  # Iterate over project_roles variable string and create a list
  # of string with format "project_id=>roles/role_name"
  project_roles = [for role in toset(split(",", var.project_roles)) :
    "${var.project_id}=>roles/${role}"
  ]
  display_name = "Service account for ${var.ilt_name}"
}

module "service_account" {
  source        = "../../../modules/gcp-service-account"
  project_id    = var.project_id
  prefix        = var.prefix
  names         = local.names
  project_roles = local.project_roles
  display_name  = local.display_name
}
