resource "random_id" "name" {
  byte_length = 2
}

locals {
  vpc_name    = format("%s-vpc-network-%s", var.ilt_name, random_id.name.hex)
  subnet_name = format("%s-%s-subnet-%s", var.ilt_name, var.subnet_region, random_id.name.hex)
}

module "vpc" {
  source = "../../../modules/gcp-vpc"

  project         = var.project_id
  vpc_name        = local.vpc_name
  subnet_name     = local.subnet_name
  subnet_region   = var.subnet_region
  subnet_ip_range = var.subnet_ip_range
}
