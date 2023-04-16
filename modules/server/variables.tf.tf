variable "environment" {
  type    = string
  description = "Current environment between Dev/Prod"
}

variable "vpc_id" {
    type    = string
    description = "VPC ID"
}

variable "subnet_ids" {
    type = list(string)
    description = "IDs of subnets"
}

variable "tg_server_private_ip" {
    type = string
    description = "Private IP for TG Backend Server"
}

variable "tg_key_name" {
    type = string
    description = "Name of TG backend server EC2 Key pair"
}

variable "tg_backend_certificate_arn" {
    type = string
    description = "ARN or the certificate to the backend origin URL"
}