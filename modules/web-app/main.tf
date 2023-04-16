resource "aws_s3_bucket" "tg-web-app-bucket" {
  bucket = "tg-web-app-${var.environment}"
  acl    = "private"

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_website_configuration" "tg-web-app-hosting" {
  bucket = aws_s3_bucket.tg-web-app-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

