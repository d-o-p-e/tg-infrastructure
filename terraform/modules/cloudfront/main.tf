resource "aws_cloudfront_origin_access_identity" "media_bucket_origin_access_identity" {
  comment = "Distribution of media bucket"
}

resource "aws_cloudfront_distribution" "media_bucket_distribution" {
  origin {
    domain_name = var.dope_media_bucket_domain_name
    origin_id   = var.dope_media_bucket_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.media_bucket_origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront Distribution for ${var.environment} media s3 bucket"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = var.public_allowed_http_methods
    cached_methods   = var.public_cached_http_methods
    target_origin_id = var.dope_media_bucket_id
    compress            = true
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_restriction_type
      locations        = var.cloudfront_restriction_countries
    }
  }

  tags = {
    Environment = var.environment
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# resource "aws_cloudfront_distribution" "tg_web_app_distribution" {
#   origin {
#     domain_name = var.tg_web_app_domain_name
#     origin_id   = var.tg_web_app_bucket_id

#     custom_origin_config {
#       http_port              = "80"
#       https_port             = "443"
#       origin_protocol_policy = "https-only"
#       origin_ssl_protocols   = ["TLSv1.2"]
#     }
#   }

#   aliases = [var.webapp_origin]

#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "Cloudfront Distribution for ${var.environment} TG Web App"
#   default_root_object = "index.html"

#   default_cache_behavior {
#     allowed_methods  = var.public_allowed_http_methods
#     cached_methods   = var.public_cached_http_methods
#     target_origin_id = var.tg_web_app_bucket_id
#     compress            = true
#     cache_policy_id = data.aws_cloudfront_cache_policy.caching_optimized_cache_policy.id

#     viewer_protocol_policy = "redirect-to-https"
#   }

#   price_class = "PriceClass_All"

#   restrictions {
#     geo_restriction {
#       restriction_type = var.cloudfront_restriction_type
#       locations        = var.cloudfront_restriction_countries
#     }
#   }

#   tags = {
#     Environment = var.environment
#   }

#   viewer_certificate {
#     acm_certificate_arn = var.tg_web_app_certificate_arn
#     cloudfront_default_certificate = false
#     ssl_support_method = "sni-only"
#     minimum_protocol_version = "TLSv1.2_2021"
#   }
# }
