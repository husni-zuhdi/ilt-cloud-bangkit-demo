locals {
  name              = "${var.ilt_name}-compute-engine"
  zone              = "${var.region}-c"
  tags              = ["${var.ilt_name}", "http"]
  service_image_uri = "gcr.io/${var.project_id}/${var.ilt_name}:0.1.0"
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../gcp-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "ip_address" {
  backend = "local"
  config = {
    path = "../gcp-ip-address/terraform.tfstate"
  }
}

data "terraform_remote_state" "service_account" {
  backend = "local"
  config = {
    path = "../gcp-service-account/terraform.tfstate"
  }
}

module "gce" {
  source     = "../../../modules/gcp-compute-engine"
  name       = local.name
  zone       = local.zone
  project_id = var.project_id

  service_name      = var.ilt_name
  service_image_uri = local.service_image_uri
  vpc_self_link     = data.terraform_remote_state.vpc.outputs.network_self_link
  subnet_self_link  = data.terraform_remote_state.vpc.outputs.subnet_self_link
  ip_address        = data.terraform_remote_state.ip_address.outputs.address
  sa_email          = data.terraform_remote_state.service_account.outputs.email
  tags              = local.tags
}
