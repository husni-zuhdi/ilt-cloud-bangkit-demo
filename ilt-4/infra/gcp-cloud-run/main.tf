data "terraform_remote_state" "cloudsql" {
  backend = "local"
  config = {
    path = "../gcp-cloud-sql/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../gcp-vpc/terraform.tfstate"
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "random_id" "name" {
  byte_length = 2
}

locals {
  db_host                       = data.terraform_remote_state.cloudsql.outputs.master_private_ip
  db_name                       = data.terraform_remote_state.cloudsql.outputs.db_name
  cloudsql_connection_instances = data.terraform_remote_state.cloudsql.outputs.master_proxy_connection
  service_name                  = format("%s-%s", var.ilt_name, random_id.name.hex)
  svpc_connector_name           = data.terraform_remote_state.vpc.outputs.svpc_connector_name
}

module "cloud_run" {
  source = "../../../modules/gcp-cloud-run"

  service_name = local.service_name
  project_id   = var.project
  location     = var.region
  image        = var.image
  ports = {
    name = "http1"
    port = 8080
  }
  noauth_data_policy = data.google_iam_policy.noauth.policy_data

  # Environment Variables injection
  env_vars = [
    { name = "DB_USER", value = var.db_user },
    { name = "DB_PASSWORD", value = var.db_password },
    { name = "DB_HOST", value = local.db_host },
    { name = "DB_PORT", value = var.db_port },
    { name = "DB_NAME", value = local.db_name }
  ]

  # Template Annotations for specific GCP connectivity
  template_annotations = {
    "run.googleapis.com/client-name"          = "terraform"
    "generated-by"                            = "terraform"
    "autoscaling.knative.dev/maxScale"        = var.max_scale
    "autoscaling.knative.dev/minScale"        = var.min_scale
    "run.googleapis.com/vpc-access-connector" = local.svpc_connector_name
    "run.googleapis.com/cloudsql-instances"   = local.cloudsql_connection_instances
    "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"
  }
}
