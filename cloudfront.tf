# This Terraform configuration file sets up an AWS CloudFront distribution with an 
# Origin Access Control (OAC) for secure access to a private S3 bucket. The configuration 
# Creates an Origin Access Control (OAC) for secure access to the S3 bucket.
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "s3-oac-access"
  description                       = "OAC for private S3 access"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "static_site" {
origin {
  domain_name = aws_s3_bucket.static_website_bucket.bucket_regional_domain_name
  origin_id   = "s3-static-site"

  origin_access_control_id = aws_cloudfront_origin_access_control.oac.id

# The `origin_access_identity` field in `s3_origin_config` is required but left empty 
  s3_origin_config {
    origin_access_identity = "" # Required, even though we're using OAC
  }
}

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-static-site"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.cert.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  aliases = [var.domain, "www.${var.domain}"]

  web_acl_id = aws_wafv2_web_acl.cloudfront_waf.arn

  tags = {
    Name = "Static Website Distribution"
  }
}
