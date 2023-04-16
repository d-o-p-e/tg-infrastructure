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

variable "db_username" {
    type = string
    description = "Username for DB"
}

variable "db_password" {
    type = string
    description = "Password for DB"
}

variable "webapp_origin" {
    type = string
    description = "Origin of web app"
}

variable "backend_origin" {
    type = string
    description = "Origin of Backend"
}

variable "fully_qualified_domain_names" {
    type = list(string)
    description = "FQDNs with certificates in Certificate Manager"
}

variable "tg_web_app_certificate_arn" {
    type = string
    description = "ARN of certificate of tg web app in US-EAST-1"
}

variable "tg_server_private_ip" {
    type = string
    description = "Private IP for TG Backend Server"
}

variable "tg_key_name" {
    type = string
    description = "Name of TG backend server EC2 Key pair"
}