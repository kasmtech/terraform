terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_primary_region

  default_tags {
    tags = var.aws_default_tags
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.secondary_regions_settings.region2.agent_region
  alias      = "region2"

  default_tags {
    tags = var.aws_default_tags
  }
}

##############################################################################
###
### Uncomment the below provider section if you want to deploy a 3rd region.
###
### Copy/paste the provider below to deploy additional regions, then refer
### to the README.md, the deployment.tf file, and the settings.tfvars file for
### code blocks to copy/paste/configure to deploy the new regions.
###
##############################################################################
# provider "aws" {
#   access_key = var.aws_access_key
#   secret_key = var.aws_secret_key
#   region     = var.secondary_regions_settings.region3.agent_region
#   alias      = "region3"

#   default_tags {
#     tags = var.aws_default_tags
#   }
# }
