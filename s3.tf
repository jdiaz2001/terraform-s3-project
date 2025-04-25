data "aws_region" "current" {}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "terraform-website-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "Static Website Bucket"
    Environment = "Production"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.static_website_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket policy to allow only CloudFront access via OAC
resource "aws_s3_bucket_policy" "allow_cloudfront_access" {
  bucket = aws_s3_bucket.static_website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipalReadOnly",
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.static_website_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.static_site.arn
          }
        }
      }
    ]
  })
}

# Versioning disabled
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.static_website_bucket.id
  versioning_configuration {
    status = "Suspended"
  }
}

# Upload static website files
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_website_bucket.bucket
  key          = "index.html"
  source       = "website/index.html"
  etag         = filemd5("website/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.static_website_bucket.bucket
  key          = "error.html"
  source       = "website/error.html"
  etag         = filemd5("website/error.html")
  content_type = "text/html"
}
