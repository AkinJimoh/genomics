resource "aws_s3_bucket" "access-logs" {
  bucket        = "${local.bucket_name}-access-logs"
  acl           = "log-delivery-write"
  force_destroy = true
}
locals {
  bucket_name = "${var.aws_bucket_prefix}-${random_integer.rand.result}"
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.main[2].id
  key    = "code/exif.zip"
  source = "${path.module}/config/config/exif.zip"
  acl    = "bucket-owner-full-control"
  etag   = filemd5("${path.module}/config/config/exif.zip")
}

resource "random_integer" "rand" {
  min = 500
  max = 7000
}

resource "aws_s3_bucket" "main" {
  count         = length(var.buckets)
  bucket        = "${local.bucket_name}-${element(var.buckets, count.index)}"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }
  logging {
    target_bucket = aws_s3_bucket.access-logs.id
    target_prefix = "logs/"
  }

  tags = {
    Name      = "gel-assigment"
    Automated = "yes"
  }
}