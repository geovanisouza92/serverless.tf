resource "aws_s3_bucket" "deployment" {
  bucket = "${var.name}"
}
