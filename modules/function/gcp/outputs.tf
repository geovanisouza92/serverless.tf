output "endpoint" {
  value       = "${google_cloudfunctions_function.function.https_trigger_url}"
  description = "Reference to the function"
}
