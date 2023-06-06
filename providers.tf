provider "google" {
  region  = var.region
  zone    = var.zone
  project = var.project_id
}

terraform {
  required_version = "1.3.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "= 4.68.0"
    }
  }
}