# Allocate IP ranges for Private Service Connection
resource "google_compute_global_address" "private_ip_alloc" {
  project       = var.project
  name          = var.private_ip_name
  purpose       = "VPC_PEERING"
  address       = var.private_ip_first_address
  address_type  = "INTERNAL"
  prefix_length = 16
  # network       = google_compute_network.vpc_network.id
  network = var.vpc_network_id
}

# Create a private connection
resource "google_service_networking_connection" "service_network_connection" {
  # network                 = google_compute_network.vpc_network.id
  network                 = var.vpc_network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

# Create Serverless VPC Access Connector
resource "google_vpc_access_connector" "svpc_connector" {
  project = var.project
  name    = var.svpc_connector_name
  # network       = google_compute_network.vpc_network.self_link
  network       = var.vpc_network_self_link
  machine_type  = var.svpc_connector_machine_type
  min_instances = var.svpc_connector_min_instances
  max_instances = var.svpc_connector_max_instances
  region        = var.subnet_region
  ip_cidr_range = var.svpc_connector_ip_range
}
