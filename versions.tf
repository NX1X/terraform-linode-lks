# versions.tf

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 2.0"
    }
  }
}
