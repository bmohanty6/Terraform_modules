variable "bucket_name"  {
    description = "Name of the bucket"
    default     = null
}
variable "bucket_prefix"  {
    description = "A unique bucket name beginning with the specified prefix"
    default     = null
}
variable "acl"  {
    description = "Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write"
    default     = null
}
variable "bucket_tags"  {
    description = "A mapping of tags to be assigned to S3 bucket"
    default     = {
        Name    = "${var.bucket_name}"
    }
}
variable "enable_force_destroy"  {
    default     = true
}
variable "enable_versioning"  {
    default     = true
}

variable "website" {
    description = "Map containing static web-site hosting or redirect configuration."
    type        = map(string)
    default     = {}
}

variable "logging" {
    description = "Map containing access bucket logging configuration."
    type        = map(string)
    default     = {}
}

variable "bucket_policy_json" {
    description = "Json content for S3 bucket policy"
    default     = null 
}