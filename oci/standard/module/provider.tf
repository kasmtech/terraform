terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.0.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = ">= 2.0.0"
    }
  }
}
