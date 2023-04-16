variable "environment" {
    type = string
    description = "Current environment between Dev/Prod"
}

variable "dope_media_bucket_id" {
    type = string
    description = "Bucket ID of the media bucket"
}

variable "dope_media_bucket_domain_name" {
    type = string
    description = "Bucket domain name of the media bucket"
}

variable "public_allowed_http_methods" {
    type = list(string)
    description = "HTTP Methods allowed to use on Cloudfront"
}

variable "public_cached_http_methods" {
    type = list(string)
    description = "HTTP Methods to cache on Cloudfront"
}

variable "cloudfront_restriction_type" {
    type = string
    description = "Type of Restriction to act"
}

variable "cloudfront_restriction_countries" {
    type = list(string)
    description = "Blacklist/Whitelist of Countries allowed to access"
}

variable "tg_web_app_bucket_id" {
    type = string
    description = "Bucket ID of TG Web App bucket"
}

variable "tg_web_app_domain_name" {
    type = string
    description = "Domain URL of the Hosted TG Web App bucket"
}

variable "webapp_origin" {
    type = string
    description = "Origin of web app"
}

variable "tg_web_app_certificate_arn" {
    type = string
    description = "ARN of certificate of tg web app in US-EAST-1"
}