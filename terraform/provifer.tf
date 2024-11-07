provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "angga-suriana-durianpay-bucket"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    acl     = "private"
  }
}
