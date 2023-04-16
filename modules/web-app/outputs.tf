output "tg_web_app_bucket_id" {
    value = aws_s3_bucket.tg-web-app-bucket.id
}
output "tg_web_app_domain_name" {
    value = aws_s3_bucket_website_configuration.tg-web-app-hosting.website_endpoint
}