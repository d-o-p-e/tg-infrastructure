output "web_app_cdn_uri" {
    value = aws_cloudfront_distribution.tg_web_app_distribution.domain_name
}

output "media_storage_cdn_uri" {
    value = aws_cloudfront_distribution.media_bucket_distribution.domain_name
}