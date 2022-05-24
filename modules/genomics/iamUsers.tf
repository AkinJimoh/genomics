resource "aws_iam_user" "users" {
  count = length(var.users)
  name  = element(var.users, count.index)
  path  = "/"

  tags = {
    Name      = "genomics"
    Automated = "yes"
  }
}

data "aws_iam_policy_document" "iam_read_write_policy" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:*object*",
    ]
    resources = [
      "${aws_s3_bucket.main[0].arn}/*",
    ]
  }
}

resource "aws_iam_user_policy" "readwrite" {
  name   = "ReadWritepolicy"
  user   = aws_iam_user.users[0].name
  policy = data.aws_iam_policy_document.iam_read_write_policy.json
}


data "aws_iam_policy_document" "iam_read_only_policy" {
  statement {
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${aws_s3_bucket.main[1].arn}/*",
    ]
  }
}

resource "aws_iam_user_policy" "readpolicy" {
  name   = "ReadPolicy"
  user   = aws_iam_user.users[1].name
  policy = data.aws_iam_policy_document.iam_read_only_policy.json
}
