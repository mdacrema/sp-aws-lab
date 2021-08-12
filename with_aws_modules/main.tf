terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.53.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = local.region
}
