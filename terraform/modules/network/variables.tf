variable "environment" {
    type = string
    description = "Current environment between Dev/Prod"
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

variable "availability_zones" {
    type = list(string)
    description = "List of Availability Zones in use"
}