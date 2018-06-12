output "ref" {
  value = "${google_cloudfunctions_function.function.https_trigger_url}"
}
