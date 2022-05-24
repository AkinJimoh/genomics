provider "aws" {
  region  = var.region
  profile = var.profile
}
terraform {
  required_providers {
    aws = "~> 3.73.0"
  }
}
module "s3Bucket" {
  source  = "./modules/genomics"
  buckets = var.buckets
  users   = var.users
}

