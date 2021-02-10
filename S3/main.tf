resource "aws_kms_key" "s3_kms_key" {
    description         = "Encryption key for ${var.bucket_name}"
    enable_key_rotation = true
    
    tags = {
        S3_bucket   = "{var.bucket_name}"
        managed_by  = "Terraform"
    }
}

resource "aws_kms_alias" "kms_alias" {
    name            = "alias/s3key-${var.bucket_name}"
    target_key_id   = "${aws_kms_key.s3_kms_key.key_id}"
    depends_on      = [
        "aws_kms_key.s3_kms_key",
    ]
}

resource "aws_s3_bucket" "s3_bucket" {
    bucket              = "${var.bucket_name}"
    bucket_prefix       = "${var.bucket_prefix}"
    acl                 = "${var.acl}"
    tags                = "${var.bucket_tags}"
    force_destroy       = "${var.enable_force_destroy}"
    policy              = "${var.bucket_policy_json}"

    versioning {
        enabled = "${var.enable_versioning}"
    }

    dynamic "website" {
        for_each = length(keys(var.website)) == 0 ? [] : [var.website]

        content {
            index_document           = lookup(website.value, "index_document", null)
            error_document           = lookup(website.value, "error_document", null)
            redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
            routing_rules            = lookup(website.value, "routing_rules", null)
        }
    }
  
    dynamic "logging" {
        for_each = length(keys(var.logging)) == 0 ? [] : [var.logging]

        content {
        target_bucket = logging.value.target_bucket
        target_prefix = lookup(logging.value, "target_prefix", null)
        }
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                kms_master_key_id   = "${aws_kms_key.s3_kms_key.arn}"
                sse_algorithm       = "aws:kms"
            }
        }
    }

}