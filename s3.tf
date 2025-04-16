data "aws_region" "current" {}

# Random generator
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# New Bucket with a Random name
resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "terraform-website-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "Static Website Bucket"
    Environment = "Production"
  }
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Enable public access block for the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.static_website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Define the S3 bucket policy to allow public access
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static_website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_website_bucket.arn}/*"
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
# Upload index.html and error.html files to the bucket
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.static_website_bucket.bucket
  key    = "index.html"
  source       = "website/index.html"
  etag         = filemd5("website/index.html")
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.static_website_bucket.bucket
  key    = "error.html"
  source       = "website/error.html"
  etag         = filemd5("website/error.html")
  content_type = "text/html"
}


