resource "aws_api_gateway_rest_api" "api_for_lambda" {
  name        = var.rest_api_name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.api_for_lambda.id
  parent_id   = aws_api_gateway_rest_api.api_for_lambda.root_resource_id
  path_part   = "lambda"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_for_lambda.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_for_lambda.id
  resource_id             = aws_api_gateway_resource.root.id
  http_method             = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = var.client_info_lambda_invoke_arn
}

resource "aws_api_gateway_method_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_for_lambda.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = "200"

    //cors section
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }

}

resource "aws_api_gateway_integration_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_for_lambda.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = aws_api_gateway_method_response.proxy.status_code

    //cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,Content-Length,DateX-Amz-Apigw-Id,X-Amzn-Errortype,X-Amzn-Requestid '",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
}
  
  depends_on = [
    aws_api_gateway_method.proxy,
    aws_api_gateway_integration.lambda_integration
  ]
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.api_for_lambda.id
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = var.iam_for_lambda_name
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.client_info_lambda_arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api_for_lambda.execution_arn}/*/*/*"
}


resource "aws_api_gateway_resource" "metric_lambda" {
  rest_api_id = aws_api_gateway_rest_api.api_for_lambda.id
  parent_id   = aws_api_gateway_rest_api.api_for_lambda.root_resource_id
  path_part   = "metric_lambda"
}

resource "aws_api_gateway_method" "metric_lambda" {
  rest_api_id = aws_api_gateway_rest_api.api_for_lambda.id
  resource_id = aws_api_gateway_resource.metric_lambda.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "metric_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api_for_lambda.id
  resource_id             = aws_api_gateway_resource.metric_lambda.id
  http_method             = aws_api_gateway_method.metric_lambda.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${var.button_click_lambda_invoke_arn}/invocations"
}

resource "aws_api_gateway_method_response" "metric_lambda" {
  rest_api_id = aws_api_gateway_rest_api.api_for_lambda.id
  resource_id = aws_api_gateway_resource.metric_lambda.id
  http_method = aws_api_gateway_method.metric_lambda.http_method
  status_code = "200"

    //cors section
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }

}

resource "aws_api_gateway_integration_response" "metric_lambda" {
  rest_api_id = aws_api_gateway_rest_api.api_for_lambda.id
  resource_id = aws_api_gateway_resource.metric_lambda.id
  http_method = aws_api_gateway_method.metric_lambda.http_method
  status_code = aws_api_gateway_method_response.metric_lambda.status_code

    //cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,Content-Length,DateX-Amz-Apigw-Id,X-Amzn-Errortype,X-Amzn-Requestid '",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
}
  
  depends_on = [
    aws_api_gateway_method.metric_lambda,
    aws_api_gateway_integration.metric_lambda
  ]
}
