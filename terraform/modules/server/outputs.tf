output "tg_load_balancer_uri" {
    value = aws_lb.tg_backend_alb.dns_name
}

output "tg_backend_server_public_ip" {
    value = aws_eip.tg_server_eip.public_ip
}