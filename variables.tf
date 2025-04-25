variable "domain" {
  type = string
  description= "The domain name for the CloudFront distribution"
}

variable "aws_region" {
  type = string
  description= "The AWS region where the S3 bucket is hosted"
}

variable "profile" {
  type = string
  description= "The AWS SSO profile to be used"
}

variable "route53_zone_id" {
  type = string
  description= "The Route53 zone_id for the domain"
}


