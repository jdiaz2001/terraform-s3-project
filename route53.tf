# Parent hosted zone for test.mynsmdev.org (only if not already defined)
resource "aws_route53_zone" "parent" {
  name = "mynsmdev.org"
}

resource "aws_route53_zone" "example" {
  name = "test.mynsmdev.org"
}

# NS delegation from test.mynsmdev.org to mynsmdev.org
resource "aws_route53_record" "test_subdomain_ns" {
  allow_overwrite = true  #if not added... another parent hosted zone will be created
  zone_id = aws_route53_zone.parent.zone_id
  name    = "test.mynsmdev.org"
  type    = "NS"
  ttl     = 300
  records = aws_route53_zone.example.name_servers
}

# add records to subdomain
resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "test.mynsmdev.org"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.static_site.domain_name
    zone_id                = aws_cloudfront_distribution.static_site.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "www.test.mynsmdev.org"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.static_site.domain_name
    zone_id                = aws_cloudfront_distribution.static_site.hosted_zone_id
    evaluate_target_health = false
  }
}


