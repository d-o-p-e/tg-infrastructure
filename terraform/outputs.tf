output "database_path" {
    value = module.database.database_path
}

output "web_app_cdn_uri" {
    value = module.cloudfront.web_app_cdn_uri
}

output "media_storage_cdn_uri" {
    value = module.cloudfront.media_storage_cdn_uri
}

output "image_repository_uri" {
    value = module.image_repository.image_repository_uri
}

output "tg_load_balancer_uri" {
    value = module.server.tg_load_balancer_uri
}

output "tg_backend_server_public_ip" {
    value = module.server.tg_backend_server_public_ip
}

output "tg_web_app_domain_name" {
    value = module.web-app.tg_web_app_domain_name
}