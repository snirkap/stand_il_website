
variable "aws_cloudfront_origin_access_control_name" {
  type        = string
  description = "the name of aws cloudfront origin access control"
  default     = "site_access"
}

variable "aws_cloudfront_distribution_aliases" {
  type        = string
  description = "aliases for alternate domain"
  default     = "surfsupsnir.com"
}

variable "aws_cloudfront_distribution_acm_certificate_arn" {
  type        = string
  description = "acm certificate arn"
  default     = "arn:aws:acm:us-east-1:064195113262:certificate/266f105d-cce1-4c60-99f1-07d17eb036bd"
}

variable "s3_bucket_website_index_document" {
  type        = string
  description = "the default file for the static website"
  default     = "stand.iL.html"
}

variable "s3_bucket_id" {
  type = string
}

variable "s3_bucket_domain_name" {
  type = string
}