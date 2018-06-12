resource "aws_api_gateway_rest_api" "proxy" {
  name        = "${var.name}"
  description = "${var.description}"
}

resource "aws_api_gateway_resource" "proxy" {
  count = "${length(var.routes)}"

  rest_api_id = "${aws_api_gateway_rest_api.proxy.id}"
  parent_id   = "${aws_api_gateway_rest_api.proxy.root_resource_id}"
  path_part   = "${element(element(var.routes, count.index), "path")}"
}

resource "aws_api_gateway_method" "proxy" {
  count = "${length(var.routes)}"

  rest_api_id   = "${aws_api_gateway_rest_api.proxy.id}"
  resource_id   = "${element(aws_api_gateway_resource.proxy.*.id, count.index)}"
  http_method   = "${element(element(var.routes, count.index), "method")}"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  count = "${length(var.routes)}"

  rest_api_id             = "${aws_api_gateway_rest_api.proxy.id}"
  resource_id             = "${element(aws_api_gateway_method.proxy.*.resource_id, count.index)}"
  http_method             = "${element(aws_api_gateway_method.proxy.*.http_method, count.index)}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${element(element(var.routes, count.index), "function")}"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    "aws_api_gateway_integration.lambda",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.proxy.id}"
  stage_name  = "${terraform.workspace}"
}
