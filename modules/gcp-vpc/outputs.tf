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

output "network_name" {
  value       = google_compute_network.vpc_network.name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = google_compute_network.vpc_network.self_link
  description = "The URI of the VPC being created"
}

output "subnet_ip_range" {
  value       = google_compute_subnetwork.vpc_subnetwork.name
  description = "The IP range of created subnet"
}

output "subnet_self_link" {
  value       = google_compute_subnetwork.vpc_subnetwork.self_link
  description = "The self link of created subnet"
}

output "private_ip_self_link" {
  value       = google_compute_global_address.private_ip_alloc.self_link
  description = "The self link of created private ip range"
}

output "svpc_connector_name" {
  value       = google_vpc_access_connector.svpc_connector.name
  description = "The name of Serverless VPC Access Connector name"
}

output "svpc_connector_ip_range" {
  value       = google_vpc_access_connector.svpc_connector.ip_cidr_range
  description = "The ip range of Serverless VPC Access Connector name"
}

output "svpc_connector_status" {
  value       = google_vpc_access_connector.svpc_connector.state
  description = "The state of Serverless VPC Access Connector name"
}
