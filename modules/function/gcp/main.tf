data "archive_file" "package" {
  type        = "zip"
  source_dir  = "${var.code_path}"
  output_path = "${path.module}/package.zip"
}

resource "google_storage_bucket_object" "package" {
  bucket = "${var.bucket}"
  name   = "package-${var.name}.zip"
  source = "${path.module}/package.zip"
}

resource "google_cloudfunctions_function" "function" {
  name                  = "${var.name}"
  description           = "${var.description}"
  entry_point           = "${var.handler}"
  available_memory_mb   = "${var.memory_size}"
  timeout               = "${var.timeout}"
  source_archive_bucket = "${var.bucket}"
  source_archive_object = "${google_storage_bucket_object.package.name}"
}
