data "archive_file" "package" {
  type        = "zip"
  source_dir  = "${var.code_path}"
  output_path = "${path.module}/package.zip"
}

resource "aws_s3_bucket_object" "package" {
  bucket = "${var.bucket}"
  key    = "package-${var.name}.zip"
  source = "${path.module}/package.zip"
}

resource "aws_lambda_function" "function" {
  function_name    = "${var.name}"
  handler          = "${var.handler}"
  description      = "${var.description}"
  memory_size      = "${var.memory_size}"
  runtime          = "${var.runtime}"
  timeout          = "${var.timeout}"
  role             = "${aws_iam_role.iam_role_for_lambda.arn}"
  s3_bucket        = "${var.bucket}"
  s3_key           = "${aws_s3_bucket_object.package.id}"
  source_code_hash = "${data.archive_file.package.output_base64sha256}"
}

resource "aws_iam_role" "iam_role_for_lambda" {
  name = "execute-${var.name}"

  assume_role_policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
POLICY
}
