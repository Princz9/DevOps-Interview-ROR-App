resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.project_name}-bucket"
  force_destroy = true

  tags = {
    Name = "${var.project_name}-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "bucket_name" {
  value = aws_s3_bucket.app_bucket.bucket
}
