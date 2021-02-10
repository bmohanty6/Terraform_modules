output "s3_bucket_name" {
    value = "${aws_s3_bucket.s3_bucket.id}"
}
output "s3_bucket_arn" {
    value = "${aws_s3_bucket.s3_bucket.arn}"
}

output "kms_key_id" {
    value = "${aws_kms_key.s3_kms_key.key_id}"
}

output "website_endpoint" {
    value = "${aws_s3_bucket.s3_bucket.website_endpoint}"
}

output "s3_bucket_domain_name" {
    value = "${aws_s3_bucket.s3_bucket.bucket_domain_name}"
}