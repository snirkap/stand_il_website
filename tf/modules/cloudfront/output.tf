output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.cloudfront_dist.arn
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cloudfront_dist.domain_name
}

output "cloudfront_hosted_zone_id" {
  value = aws_cloudfront_distribution.cloudfront_dist.hosted_zone_id
}