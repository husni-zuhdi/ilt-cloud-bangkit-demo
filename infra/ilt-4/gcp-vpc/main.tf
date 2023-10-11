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
  vpc_name        = format("%s-vpc-network-%s", var.ilt_name, random_id.name.hex)
  subnet_name     = format("%s-%s-subnet-%s", var.ilt_name, var.subnet_region, random_id.name.hex)
  private_ip_name = format("%s-private-ip-%s", var.ilt_name, random_id.name.hex)
  svpc_name       = format("%s-svpc-connector-%s", var.ilt_name, random_id.name.hex)
}

# Activate Serverless VPC Access google API
# resource "google_project_service" "vpcaccess-api" {
#   project = var.project
#   service = "vpcaccess.googleapis.com"
# }

# Create VPC network
resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = local.vpc_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

# Create a subnet inside VPC network
resource "google_compute_subnetwork" "vpc_subnetwork" {
  project                  = var.project
  name                     = local.subnet_name
  ip_cidr_range            = var.subnet_ip_range
  region                   = var.subnet_region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

# Allocate IP ranges for Private Service Connection
resource "google_compute_global_address" "private_ip_alloc" {
  project       = var.project
  name          = local.private_ip_name
  purpose       = "VPC_PEERING"
  address       = "11.255.0.0"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

# Create a private connection
resource "google_service_networking_connection" "service_network_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

# Create Serverless VPC Access Connector
resource "google_vpc_access_connector" "svpc_connector" {
  project       = var.project
  name          = local.svpc_name
  network       = google_compute_network.vpc_network.self_link
  machine_type  = "f1-micro"
  min_instances = 2
  max_instances = 3
  region        = var.subnet_region
  ip_cidr_range = "11.254.0.0/28"
  depends_on    = [google_project_service.vpcaccess-api]
}
