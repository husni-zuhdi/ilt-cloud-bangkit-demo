locals {
  name = "${var.ilt_name}-allow-ssh-from-iap"
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../../gcp-vpc/terraform.tfstate"
  }
}

module "fw" {
  source            = "../../../../modules/gcp-firewall-rule"
  name              = local.name
  project_id        = var.project_id
  ports             = ["22"]
  protocol          = "tcp"
  network_self_link = data.terraform_remote_state.vpc.outputs.network_self_link
  source_ranges     = ["35.235.240.0/20"]
}
