variable "environment" {
    type = string
    description = "Current environment between Dev/Prod"
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