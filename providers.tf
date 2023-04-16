terraform {
  backend "s3" {
    bucket = "dope-infra-states"
    key    = "terraform/terraform.tfstate"
    region         = "ap-northeast-2"  
    encrypt        = true
  }
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region = var.region
}