provider "aws" {
  region = local.region

  assume_role {
    role_arn = "arn:aws:iam::925880893941:role/terraform-role"
  }
  
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49"
    }
  }
}
