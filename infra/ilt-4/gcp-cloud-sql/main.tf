# ------------------------------------------------------------------------------
# LAUNCH A POSTGRES CLOUD SQL PRIVATE IP INSTANCE
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# CONFIGURE OUR GCP CONNECTION
# ------------------------------------------------------------------------------

provider "google-beta" {
  project = var.project
  region  = var.region
}

terraform {
  # This module is now only being tested with Terraform 1.0.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 1.0.x code.
  required_version = ">= 0.12.26"

  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.57.0"
    }
  }
}

# ------------------------------------------------------------------------------
# CREATE A RANDOM SUFFIX AND PREPARE RESOURCE NAMES
# ------------------------------------------------------------------------------

resource "random_id" "name" {
  byte_length = 2
}

locals {
  # If name_override is specified, use that - otherwise use the name_prefix with a random string
  instance_name = var.name_override == null ? format("%s-%s-%s", var.name_prefix, var.ilt_name, random_id.name.hex) : var.name_override
}

# ------------------------------------------------------------------------------
# CREATE COMPUTE NETWORKS
# ------------------------------------------------------------------------------

# Get Data of VPC
data "google_compute_network" "private_network" {
  provider = google-beta
  name     = var.vpc_network_name
}

# ------------------------------------------------------------------------------
# CREATE DATABASE INSTANCE WITH PRIVATE IP
# ------------------------------------------------------------------------------

module "postgres" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "github.com/gruntwork-io/terraform-google-sql.git//modules/cloud-sql?ref=v0.2.0"
  source = "../../modules/gcp-cloud-sql"

  project = var.project
  region  = var.region
  name    = local.instance_name
  db_name = var.db_name

  engine       = var.postgres_version
  machine_type = var.machine_type

  # To make it easier to test this example, we are disabling deletion protection so we can destroy the databases
  # during the tests. By default, we recommend setting deletion_protection to true, to ensure database instances are
  # not inadvertently destroyed.
  deletion_protection = false

  # These together will construct the master_user privileges, i.e.
  # 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'.
  # These should typically be set as the environment variable TF_VAR_master_user_password, etc.
  # so you don't check these into source control."
  master_user_password = var.master_user_password

  master_user_name = var.master_user_name
  master_user_host = "%"

  # Pass the private network link to the module
  private_network = data.google_compute_network.private_network.self_link

  custom_labels = {
    test-id = "postgres-private-ip-example"
    ilt     = var.ilt_name
  }
}