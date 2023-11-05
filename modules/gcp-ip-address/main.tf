resource "google_compute_address" "ip" {
  project      = var.project_id
  region       = var.region
  name         = var.name
  address_type = "EXTERNAL"
}
