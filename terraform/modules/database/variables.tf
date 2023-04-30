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

variable "db_username" {
    type = string
    description = "Username for DB"
}

variable "db_password" {
    type = string
    description = "Password for DB"
}