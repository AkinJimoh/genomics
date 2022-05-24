output "lambda_role" {
  value = [aws_iam_role.lambda_role.arn]
}

output "source_bucket_arn" {
  value = aws_s3_bucket.main[0].arn
}

output "destination_bucket_arn" {
  value = aws_s3_bucket.main[1].arn
}