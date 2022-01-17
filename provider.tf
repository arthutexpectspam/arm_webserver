provider "aws" {
  region     = "eu-west-2"
}
terraform {
  backend "s3" {
    bucket = "2112it"
    key    = "terraform/arm_webserver1/terraform.tfstate"
    region = "eu-west-2"
  }
}
