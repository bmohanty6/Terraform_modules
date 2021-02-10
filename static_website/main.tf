provider "aws" {
    region  = "${var.aws_region}"
}

module "s3_bucket_website_logging" {
    source                  = "git::https://github.com/bmohanty6/Terraform_modules.git//S3?ref=master"
    bucket_name             = "${var.logs_bucket_name}"
    acl                     = "log-delivery-write"
    enable_force_destroy    = true
    bucket_tags             = "${var.logs_bucket_tags}"
}

module "s3_bucket_website" {
    source                  = "git::https://github.com/bmohanty6/Terraform_modules.git//S3?ref=master"
    bucket_name             = "${var.website_bucket_name}"
    acl                     = "public-read"
    enable_force_destroy    = true
    bucket_tags             = "${var.website_bucket_tags}"
    bucket_policy_json      = "${var.website_bucket_policy_json}"
    
    logging {
        target_bucket   = "${module.s3_bucket_website_logging.bucket_name}"
        target_prefix   = "${var.website-domain-main}/"
    }

    website {
        index_document  = "${var.index_html_file}"
        error_document  = "${var.error_html_file}"
        routing_rules   = "${var.website_routing_rules_json}"
    }
}