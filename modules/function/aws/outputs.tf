output "endpoint" {
  value       = "${aws_lambda_function.function.arn}"
  description = "Reference to the function"
}
