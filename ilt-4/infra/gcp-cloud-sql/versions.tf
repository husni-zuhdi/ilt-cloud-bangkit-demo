provider "google-beta" {
  project = var.project
  region  = var.region
}

terraform {
  required_version = ">= 0.12.26"

  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.57.0"
    }
  }
}
