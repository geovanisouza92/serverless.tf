data "aws_s3_bucket" "deployment" {
  bucket = "serverless-deployments"
}

resource "aws_s3_bucket_object" "package" {
  bucket = "${data.aws_s3_bucket.deployment.id}"
  key    = "package.zip"
  source = "${var.code_path}"
}

resource "aws_lambda_function" "function" {
  function_name    = "${var.name}"
  handler          = "${var.handler}"
  description      = "${var.description}"
  memory_size      = "${var.memory_size}"
  runtime          = "${var.runtime}"
  timeout          = "${var.timeout}"
  s3_bucket        = "${data.aws_s3_bucket.deployment.id}"
  s3_key           = "${aws_s3_bucket_object.package.arn}"
  source_code_hash = "${base64sha256(file(var.code_path))}"
}
