variable "aws_route53_record_zone_id" {
  type        = string
  description = "zone id"
  default     = "Z02699943I5DTUSUR4A3X"
}

variable "aws_route53_record_name" {
  type        = string
  description = "name of the record"
  default     = "surfsupsnir.com"
}


variable "cloudfront_domain_name" {
  type = string
}

variable "cloudfront_hosted_zone_id" {
  type = string
}