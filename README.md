# **Politicia Infrastructure**

Politicia Infrastructure organized by Terraform.

Mainly powered by AWS.

## **Modules**

- Network : Virtual Network Configuration on AWS to VPC, Route Table, IGW, etc.
- S3 : 3 S3 Buckets for each environment; Images, Videos, Profile Images.
- Cloudfront : Connect S3 Buckets to CDN

## **Requirements**

- Need `development.tfvars` or `production.tfvars` to edit the following environment.
  used variables:

```
AWS_ACCESS_KEY (STRING) : Access Key for AWS account

AWS_SECRET_KEY (STRING) : Secret Key for AWS account

region (STRING) : region of environment in AWS

politicia_media_cors_allowed_origins (LIST(STRING)) : S3 CORS configuration for Image & Video Bucket

politicia_thumbnail_cors_allowed_origins (LIST(STRING)) : List of URLs to S3 CORS configuration for Thumbnail Bucket

vpc_cidr (STRING) : Subnet Mask of VPC

public_subnets_cidr (LIST(STRING)) : Subnet Mask of Public Subnets as a List

private_subnets_cidr = (LIST(STRING)) : Subnet Mask of Private Subnets as a List

cloudfront_public_allowed_http_methods (LIST(STRING)) : HTTP Methods allowed to use on Cloudfront

cloudfront_public_cached_http_methods = (LIST(STRING)) : HTTP Methods to cache on Cloudfront

cloudfront_restriction_type (STRING) : Type of Restriction to act

cloudfront_restriction_countries (LIST(STRING)) : Blacklist/Whitelist of Countries allowed to access

db_username (STRING) : Username for DB

db_password (STRING) : Password for DB

webapp_origin (STRING) : Origin URL of Web app

backend_origin (STRING) : Origin URL of Backend

fully_qualified_domain_names (LIST(STRING)) : FQDNs with certificates in Certificate Manager

tg_web_app_certificate_arn (STRING) : ARN of certificate of tg Web App in US-EAST-1

tg_server_private_ip (STRING) : Private IP for TG Backend Server

tg_key_name (STRING) : Name of TG backend server EC2 Key pair
```



## **Usage**



### Create workspaces
use `terraform workspace new production`, `terraform workspace new development` to create each environment.


---

### Build the Infrastructure
- Using Taskfile for easy command input.
```
task dev
    - terraform workspace select development
    - terraform init
    - terraform apply -var-file="development.tfvars"

task prod
    - terraform workspace select production
    - terraform init
    - terraform apply -var-file="production.tfvars"
```
