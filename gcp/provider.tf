terraform {
  required_version = "~> 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.64, < 6"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 2.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  credentials = local.gcp_credentials
}

provider "google-beta" {
  project     = var.project_id
  credentials = local.gcp_credentials
}
