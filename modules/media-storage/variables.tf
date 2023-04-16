variable "environment" {
  type    = string
  description = "Current environment between Dev/Prod"
}

variable "dope_media_cors_allowed_origins" {
  type    = list(string)
  description = "S3 CORS configuration for Media Bucket"
}