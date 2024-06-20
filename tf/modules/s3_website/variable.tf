variable "s3_bucket_name" {
  type        = string
  description = "the name of the bucket"
  default     = "standiltf"
}

variable "s3_bucket_website_index_document" {
  type        = string
  description = "the default file for the static website"
  default     = "stand.iL.html"
}

variable "cloudfront_distribution_arn" {
  type = string
}