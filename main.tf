locals {
  production_availability_zones  = ["${var.region}a", "${var.region}c", "${var.region}d"]
  development_availability_zones = ["${var.region}a", "${var.region}c"]
  environment                    = terraform.workspace
  tag                            = "managed via Terraform"
}

module "network" {
  source                   = "./modules/network"
  environment              = local.environment
  vpc_cidr                 = var.vpc_cidr
  public_subnets_cidr      = var.public_subnets_cidr
  private_subnets_cidr     = var.private_subnets_cidr
  availability_zones       = local.environment == "development" ? local.development_availability_zones : local.production_availability_zones
}

module "database" {
  source      = "./modules/database"
  environment = local.environment
  vpc_id      = module.network.vpc_id
  subnet_ids  = module.network.subnet_ids
  db_username = var.db_username
  db_password = var.db_password
}

module "media-storage" {
  source                                    = "./modules/media-storage"
  environment                               = local.environment
  dope_media_cors_allowed_origins           = var.dope_media_cors_allowed_origins
}

module "web-app" {
  source                                    = "./modules/web-app"
  environment                               = local.environment
}

module "certificate" {
  source  = "./modules/certificate"
  environment = local.environment
  webapp_origin = var.webapp_origin
  backend_origin = var.backend_origin
  fully_qualified_domain_names = var.fully_qualified_domain_names
}

module "cloudfront" {
  source                            = "./modules/cloudfront"
  environment                       = local.environment
  dope_media_bucket_id              = module.media-storage.dope_media_bucket_id
  dope_media_bucket_domain_name     = module.media-storage.dope_media_bucket_domain_name
  public_allowed_http_methods       = var.cloudfront_public_allowed_http_methods
  public_cached_http_methods        = var.cloudfront_public_cached_http_methods
  cloudfront_restriction_type       = var.cloudfront_restriction_type
  cloudfront_restriction_countries  = var.cloudfront_restriction_countries
  tg_web_app_bucket_id              = module.web-app.tg_web_app_bucket_id
  tg_web_app_domain_name            = module.web-app.tg_web_app_domain_name
  webapp_origin                     = var.webapp_origin
  tg_web_app_certificate_arn        = var.tg_web_app_certificate_arn
}

module "server" {
  source = "./modules/server"
  environment           = local.environment
  vpc_id                = module.network.vpc_id
  subnet_ids            = module.network.subnet_ids
  tg_server_private_ip  = var.tg_server_private_ip
  tg_key_name           = var.tg_key_name
  tg_backend_certificate_arn = module.certificate.tg_backend_certificate_arn
}