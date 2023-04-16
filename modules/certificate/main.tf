resource "aws_acm_certificate" "web_app_certificate" {
  domain_name       = var.webapp_origin
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_acm_certificate" "backend_certificate" {
    domain_name = var.backend_origin
    validation_method = "DNS"

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Environment = var.environment
    }
}