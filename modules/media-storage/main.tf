resource "aws_s3_bucket" "dope_media" {
  bucket = "dope-media-${var.environment}"
  acl    = "private"

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_object" "media_image_dir" {
  bucket = aws_s3_bucket.dope_media.id
  key    = "image/"
}

resource "aws_s3_bucket_object" "media_video_dir" {
  bucket = aws_s3_bucket.dope_media.id
  key    = "video/"
}

resource "aws_s3_bucket_object" "media_profile_image_dir" {
  bucket = aws_s3_bucket.dope_media.id
  key    = "profile_pic/"
}

resource "aws_s3_bucket_policy" "media_public_read_policy" {
  bucket = aws_s3_bucket.dope_media.id
  policy = file("${path.module}/policy/${var.environment}-media.json")
}

resource "aws_s3_bucket_versioning" "dope_media_versioning" {
  bucket = aws_s3_bucket.dope_media.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_cors_configuration" "dope_media_cors" {
  bucket = aws_s3_bucket.dope_media.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = var.dope_media_cors_allowed_origins
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}
