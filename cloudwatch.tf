# High 5xx Errors
resource "aws_cloudwatch_metric_alarm" "cloudfront_5xx_errors" {
  alarm_name          = "High-CloudFront-5xx-Errors for ${var.domain}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "5xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  dimensions = {
    DistributionId = aws_cloudfront_distribution.static_site.id
    Region         = "Global"
  }
  alarm_description   = "Triggered when 5xx errors exceed 1%"
  treat_missing_data  = "notBreaching"
}

# High 4xx Errors
resource "aws_cloudwatch_metric_alarm" "cloudfront_4xx_errors" {
  alarm_name          = "High-CloudFront-4xx-Errors for ${var.domain}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "4xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 60
  statistic           = "Average"
  threshold           = 5
  dimensions = {
    DistributionId = aws_cloudfront_distribution.static_site.id
    Region         = "Global"
  }
  alarm_description   = "Triggered when 4xx errors exceed 5%"
  treat_missing_data  = "notBreaching"
}

# Total Error Rate
resource "aws_cloudwatch_metric_alarm" "cloudfront_total_errors" {
  alarm_name          = "High-CloudFront-Total-Errors for ${var.domain}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "TotalErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 60
  statistic           = "Average"
  threshold           = 5
  dimensions = {
    DistributionId = aws_cloudfront_distribution.static_site.id
    Region         = "Global"
  }
  alarm_description   = "Triggered when total error rate exceeds 5%"
  treat_missing_data  = "notBreaching"
}

# Origin Latency
resource "aws_cloudwatch_metric_alarm" "cloudfront_origin_latency" {
  alarm_name          = "CloudFront-High-Origin-Latency for ${var.domain}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "OriginLatency"
  namespace           = "AWS/CloudFront"
  period              = 60
  statistic           = "Average"
  threshold           = 1.0
  dimensions = {
    DistributionId = aws_cloudfront_distribution.static_site.id
    Region         = "Global"
  }
  alarm_description   = "Triggered when origin latency is high"
  treat_missing_data  = "notBreaching"
}

# Low Cache Hit Rate
resource "aws_cloudwatch_metric_alarm" "cloudfront_low_cache_hit" {
  alarm_name          = "CloudFront-Low-Cache-Hit-Rate for ${var.domain}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CacheHitRate"
  namespace           = "AWS/CloudFront"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  dimensions = {
    DistributionId = aws_cloudfront_distribution.static_site.id
    Region         = "Global"
  }
  alarm_description   = "Triggered when Cache Hit Rate drops below 80%"
  treat_missing_data  = "notBreaching"
}
