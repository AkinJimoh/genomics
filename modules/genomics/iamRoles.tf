data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.main[0].arn,
      aws_s3_bucket.main[1].arn
    ]
  }
  statement {
    actions = [
      "s3:*object*",
    ]
    resources = [
      "${aws_s3_bucket.main[0].arn}/*",
      "${aws_s3_bucket.main[1].arn}/*",
    ]
  }
  statement {
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogGroup",
      "logs:CreateLogStream"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
  statement {
    actions = [
      "cloudwatch:PutMetricData"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role" "lambda_role" {
  name                  = "elif-lambda-role"
  assume_role_policy    = data.aws_iam_policy_document.lambda_assume_role.json
  path                  = "/"
  force_detach_policies = true
}
resource "aws_iam_policy_attachment" "role-policy-attachment" {
  name       = "policy-attachment"
  roles      = [aws_iam_role.lambda_role.id]
  policy_arn = aws_iam_policy.lambda_role_policy.arn
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole", ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "lambda_role_policy" {
  name   = "AWSLambdaS3Policy"
  path   = "/"
  policy = data.aws_iam_policy_document.s3_policy.json
}