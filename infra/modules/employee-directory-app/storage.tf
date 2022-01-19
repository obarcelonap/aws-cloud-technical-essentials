resource "aws_s3_bucket" "employee_directory_app_photo_bucket" {
  bucket = "employee-photo-bucket-ob-024"

  tags = {
    name = "employee_directory_app_photo_bucket"
  }
}

resource "aws_s3_bucket_policy" "employee_directory_app_photo_bucket_policy" {
  bucket = aws_s3_bucket.employee_directory_app_photo_bucket.id
  policy = data.aws_iam_policy_document.employee_directory_app_photo_bucket_policy_data.json
}

data "aws_iam_policy_document" "employee_directory_app_photo_bucket_policy_data" {
  version = "2012-10-17"
  statement {
    sid    = "AllowS3ReadAccess"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.ec2_s3_dynamodb_full_access_role.arn]
    }

    actions = [
      "s3:*",
    ]

    resources = [
      aws_s3_bucket.employee_directory_app_photo_bucket.arn,
      "${aws_s3_bucket.employee_directory_app_photo_bucket.arn}/*",
    ]
  }
}
