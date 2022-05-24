resource "aws_s3_bucket_notification" "event_notification" {
  bucket = aws_s3_bucket.main[0].id

  lambda_function {
    lambda_function_arn = aws_lambda_function.main["ExifStrippingLambda"].arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}


