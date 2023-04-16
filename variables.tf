variable "AWS_ACCESS_KEY" {
  type = string
  description = "AWS Access Key"
}

variable "AWS_SECRET_KEY" {
  type = string
  description = "AWS Secret Key"
}

variable "region" {
  type = string
  description = "AWS Region in use"
}

variable "dope_media_cors_allowed_origins" {
  type    = list(string)
  description = "S3 CORS configuration for Media Bucket"
}

variable "dope_thumbnail_cors_allowed_origins" {
  type    = list(string)
  description = "S3 CORS configuration for Thumbnail Bucket"
}

variable "vpc_cidr" {
    type = string
    description = "Subnet Mask of VPC"
}

variable "public_subnets_cidr" {
    type = list(string)
    description = "Subnet Mask of Public Subnets as a List"
}

variable "private_subnets_cidr" {
    type = list(string)
    description = "Subnet Mask of Private Subnets as a List"
}

variable "cloudfront_public_allowed_http_methods" {
    type = list(string)
    description = "HTTP Methods allowed to use on Cloudfront"
}

variable "cloudfront_public_cached_http_methods" {
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