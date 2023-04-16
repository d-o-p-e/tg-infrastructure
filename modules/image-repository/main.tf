provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_ecrpublic_repository" "tg_core_service_repository" {
  provider = aws.us_east_1

  repository_name = "tg-core-service"

  catalog_data {
    about_text        = "TG Core Service"
    architectures     = ["x86-64"]
    operating_systems = ["Linux"]
  }

  tags = {
    env = "production"
  }
}