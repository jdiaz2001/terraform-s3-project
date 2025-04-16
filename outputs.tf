# Output the website URL
output "website_url" {
  value       = "http://${aws_s3_bucket.static_website_bucket.bucket}.s3-website-${data.aws_region.current.name}.amazonaws.com"
  description = "The URL of the static website"
}

output "cloudfront_url" {
  description = "The full URL of the CloudFront distribution"
  value       = "https://${aws_cloudfront_distribution.static_site.domain_name}"
}