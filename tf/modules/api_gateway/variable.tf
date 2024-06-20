variable "rest_api_name" {
    type = string
    description = "the name of the rest api getway"
    default = "api_for_lambda"
}

variable "aws_api_gateway_deployment_name" {
  type        = string
  description = "The name of the API Gateway deployment stage"
  default     = "dev"
}

variable "client_info_lambda_invoke_arn" {
  description = "Invoke ARN of the client info Lambda function"
  type        = string
}

variable "client_info_lambda_function_name" {
  description = "Name of the client info Lambda function"
  type        = string
}

variable "button_click_lambda_invoke_arn" {
  description = "Invoke ARN of the button click Lambda function"
  type        = string
}

variable "iam_for_lambda_name" {
  description = "Name of the IAM role for Lambda"
  type        = string
}

variable "client_info_lambda_arn" {
  description = "client info lambda arn"
  type        = string
}