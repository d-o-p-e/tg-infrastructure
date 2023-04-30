output "tg_backend_certificate_arn" {
    value = aws_acm_certificate.backend_certificate.arn
}

output "tg_web_app_certificate_arn" {
    value = aws_acm_certificate.web_app_certificate.arn
}