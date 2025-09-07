# Kasm Terraform Projects

These projects are intended to be starting examples and for automating Kasm Workspaces deployments via terraform.
Administators should review the projects and add additional customizations and security enhancements as desired.

> ***NOTE:*** All of these deployments have been tested and validated with both [Terraform](https://www.terraform.io/) and [OpenTofu](https://opentofu.org/). For production deployments, we strongly advise using the [official workspace release](https://kasmweb.com/downloads). Please ensure you update the `kasm_build` and `kasm_version` variables accordingly. The current environment is specifically for testing the developer preview build of Kasm Workspaces.

# AWS
- [Multi-Server Single Region](aws/standard/README.md)
- [Multi-Region](aws/multi_region/README.md)

# Oracle Cloud
- [Single Server](oci/single_server/README.md)
- [Multi-Server Single Region](oci/standard/README.md)

# DigitalOcean
- [Single Server](digitalocean/single_server/README.md)

# GCP
- [GCP Requirements](gcp/README.md)
- [Multi-Server Single Region](gcp/MULTI_SERVER.md)
- [Multi-Region](gcp/MULTI_REGION.md)