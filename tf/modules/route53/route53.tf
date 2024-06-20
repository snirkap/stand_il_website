resource "aws_route53_record" "cloudfront_alias" {
  zone_id = var.aws_route53_record_zone_id  
  name    = var.aws_route53_record_name
  type    = "A"
  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health= true
  }
}