resource "google_storage_bucket" "deployments" {
  name = "${var.name}"
}
