resource "google_storage_bucket_object" "package" {
  bucket = "${var.bucket}"
  name   = "package.zip"
  source = "${var.code_path}"
}

resource "google_cloudfunctions_function" "function" {
  name                  = "${var.name}"
  description           = "${var.description}"
  entry_point           = "${var.handler}"
  available_memory_mb   = "${var.memory_size}MB"
  timeout               = "${var.timeout}"
  source_archive_bucket = "${var.bucket}"
  source_archive_object = "${google_storage_bucket_object.package.name}"
}
