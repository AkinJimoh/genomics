variable "buckets" {
  type    = list(string)
  default = []

}

variable "aws_bucket_prefix" {
  type    = string
  default = "gel"
}

locals {
  LambdaSettings = {
    "ExifStrippingLambda" = {
      handler     = "exif.lambda_handler",
      description = "Exif metadata strip"

      variables = {
        "DEST_BUCKET" = aws_s3_bucket.main[1].id
        "SRC_BUCKET"      = aws_s3_bucket.main[0].id
      }
    }
  }
}

variable "users" {
  type    = list(string)
  default = []
}