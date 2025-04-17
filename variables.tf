variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "profile" {
  type        = string
  description = "AWS SSO Profile to be used"
}

variable "parent_domain" {
  type        = string
  description = "The parent domain name for the website"
}

variable "subdomain" {
  type        = string
  description = "The subdomain name for the website"
}

variable "route53_zone_id" {
  type        = string
  description = "Domain Hosted Zone ID"
}

