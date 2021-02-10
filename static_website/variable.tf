variable "aws_region" {
    description = "Aws target region"
    default     = "us-east-1"
}

variable "website-domain-main" {
    description = "Domain name of website"
    default     = null
}

locals {
    domain_name = "${var.website-domain-main}"
}

variable "website_bucket_name" {
    description = "S3 bucket name for storing static website"
    default     = "${local.domain_name}-content"
}
variable "logs_bucket_name" {
    description = "S3 bucket name for storing website logs"
    default     = "${var.domain_name}-logs"
}

variable "website_bucket_tags" {
    description = "Tags for S3 bucket with Website content"
    default     = null
}

variable "logs_bucket_tags" {
    description = "Tags for logs S3 bucket"
    default     = null
}

variable "website_bucket_policy_json" {
    description = "Json policy for S3 bucket policy for Website S3 bucket"
    default     = file("website_bucket_policy.json")
}

variable "index_html_file" {
    description = "FIle name which will be index of website"
    default     = "index.html"
}

variable "error_html_file" {
    description = "FIle name which will be error.html of website"
    default     = "error.html"
}

variable "website_routing_rules_json" {
    description = "Json content for wesite routing rules"
    default     = file("website_routing_rules.json")
}