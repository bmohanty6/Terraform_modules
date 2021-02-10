output "website_bucket_name" {
    value = "${module.s3_bucket_website.s3_bucket_name}"
}

output "website_endpoint" {
    value = "${module.s3_bucket_website.website_endpoint}"
}

output "logging_bucket_name" {
    value = "${module.s3_bucket_website_logging.s3_bucket_name}"
}