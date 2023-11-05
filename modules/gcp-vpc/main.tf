# Create VPC network
resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = var.vpc_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

# Create a subnet inside VPC network
resource "google_compute_subnetwork" "vpc_subnetwork" {
  project                  = var.project
  name                     = var.subnet_name
  ip_cidr_range            = var.subnet_ip_range
  region                   = var.subnet_region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}
