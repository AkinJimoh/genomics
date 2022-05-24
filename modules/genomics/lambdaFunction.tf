resource "aws_lambda_function" "main" {
  for_each      = local.LambdaSettings
  function_name = each.key
  handler       = each.value.handler
  description   = each.value.description
  s3_bucket     = aws_s3_bucket.main[2].id
  s3_key        = aws_s3_bucket_object.object.key
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.7"
  memory_size   = "2048"
  timeout       = "600"
  environment {
    variables = each.value.variables
  }
}

resource "aws_cloudwatch_log_group" "cloudtrail_elifstriping" {
  name              = "/aws/lambda/ExifStrippingLambda"
  retention_in_days = "7"
  tags = {
    Name      = "gel-assigment"
    Automated = "yes"
  }
}
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "s3InvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main["ExifStrippingLambda"].function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.main[0].arn

}
