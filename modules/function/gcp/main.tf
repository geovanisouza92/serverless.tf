data "google_storage_bucket" "deployment" {
  name = "serverless-deployments"
}

resource "google_storage_bucket_object" "package" {
  bucket = "${data.google_storage_bucket.deployment}"
  name   = "package.zip"
  source = "${var.code_path}"
}

resource "google_cloudfunctions_function" "function" {
  name                  = "${var.name}"
  description           = "${var.description}"
  entry_point           = "${var.handler}"
  available_memory_mb   = "${var.memory_size}MB"
  timeout               = "${var.timeout}"
  source_archive_bucket = "${data.google_storage_bucket.deployment.name}"
  source_archive_object = "${google_storage_bucket_object.package.name}"
}
