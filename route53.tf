resource "aws_route53_zone" "example" {
  name = var.domain
}

# NS delegation from test.mynsmdev.org to mynsmdev.org
resource "aws_route53_record" "test_subdomain_ns" {
  allow_overwrite = true # Allow overwriting existing records
  zone_id = var.route53_zone_id # The hosted zone ID for the parent domain
  name    = var.domain
  type    = "NS"
  ttl     = 300
  records = aws_route53_zone.example.name_servers
}

# add records to subdomain
resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.example.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.static_site.domain_name
    zone_id                = aws_cloudfront_distribution.static_site.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "www.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.static_site.domain_name
    zone_id                = aws_cloudfront_distribution.static_site.hosted_zone_id
    evaluate_target_health = false
  }
}


