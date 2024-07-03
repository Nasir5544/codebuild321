provider "aws" {
  region = "us-east-1"
}

# S3 bucket for storing uploaded files
resource "aws_s3_bucket" "file_storage" {
  bucket = "buildcode123"
}

# Disable public access block
resource "aws_s3_bucket_public_access_block" "file_storage_public_access" {
  bucket                  = aws_s3_bucket.file_storage.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 bucket policy for public read access
resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.file_storage.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.file_storage.arn}/*"
      }
    ]
  })
}
