/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  names = ["${var.sa_name}-${var.ilt_name}"]
  # Iterate over project_roles variable string and create a list
  # of string with format "project_id=>roles/role_name"
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

