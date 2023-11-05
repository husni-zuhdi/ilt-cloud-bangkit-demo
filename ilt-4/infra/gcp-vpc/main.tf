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

resource "random_id" "name" {
  byte_length = 2
}

locals {
  vpc_name    = format("%s-vpc-network-%s", var.ilt_name, random_id.name.hex)
  subnet_name = format("%s-%s-subnet-%s", var.ilt_name, var.subnet_region, random_id.name.hex)
}

module "vpc" {
  source = "../../../modules/gcp-vpc"

  project         = var.project
  vpc_name        = local.vpc_name
  subnet_name     = local.subnet_name
  subnet_region   = var.subnet_region
  subnet_ip_range = var.subnet_ip_range
}
