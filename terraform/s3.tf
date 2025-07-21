resource "aws_s3_bucket" "ror_bucket" {
  bucket = "${var.project_name}-ror-s3"
  force_destroy = true
}
