resource "random_id" "name" {
  byte_length = 2
}

locals {
  private_ip_name = format("%s-private-ip-%s", var.ilt_name, random_id.name.hex)
  svpc_name       = format("%s-svpc-connector-%s", var.ilt_name, random_id.name.hex)
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../gcp-vpc/terraform.tfstate"
  }
}

module "vpc" {
  source = "../../../modules/gcp-svpc"

  project               = var.project
  vpc_network_id        = data.terraform_remote_state.vpc.outputs.network_id
  vpc_network_self_link = data.terraform_remote_state.vpc.outputs.network_self_link

  private_ip_name          = local.private_ip_name
  private_ip_first_address = var.private_ip_first_address

  svpc_connector_name          = local.svpc_name
  svpc_connector_machine_type  = var.svpc_connector_machine_type
  svpc_connector_min_instances = var.svpc_connector_min_instances
  svpc_connector_max_instances = var.svpc_connector_max_instances
  svpc_connector_ip_range      = var.svpc_connector_ip_range
}
