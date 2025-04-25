# Output the website URL
output "cloudfront_url" {
  description = "The full URL of the CloudFront distribution"
  value       = "https://${aws_cloudfront_distribution.static_site.domain_name}"
}