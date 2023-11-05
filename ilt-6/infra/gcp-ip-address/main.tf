resource "random_id" "name" {
  byte_length = 2
}

locals {
  ip_name = format("%s-ip-address-%s", var.ilt_name, random_id.name.hex)
}

module "ip" {
  source = "../../../modules/gcp-ip-address"

  project_id = var.project_id
  name       = local.ip_name
  region     = var.region
}
