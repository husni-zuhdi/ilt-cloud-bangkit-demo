locals {
  names = ["${var.sa_name}-${var.ilt_name}"]
  project_roles = [for role in toset(split(",", var.project_roles)) :
    "${var.project}=>roles/${role}"
  ]
  display_name = "${var.sa_display_name} service account for ${var.ilt_name}"
}

module "service_accounts" {
  source        = "../../../modules/gcp-service-account"
  project_id    = var.project
  prefix        = var.prefix
  names         = local.names
  project_roles = local.project_roles
  display_name  = local.display_name
  description   = local.display_name
}

