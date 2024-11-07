provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "durianpay-bucket-angga-suriana"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    acl     = "private"
  }
}
