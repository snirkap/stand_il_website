variable "button_click_lambda_name" {
    type = string
    description = "the name of the button click lambda"
    default = "ButtonClickLambda"
}

variable "iam_for_lambda_metric_name" {
    type = string
    description = "the name of the iam for lambda metric"
    default = "lambda_execution_role_for_button_click"
}

variable "cloudwatch_policy_name" {
    type = string
    description = "the name of the cloudwatch policy"
    default = "CloudWatchPutMetricGetMetricDataPolicy"
}

variable "cloudwatch_dashboard_name" {
    type = string
    description = "the name of the cloudwatch policy"
    default = "ButtonClickDashboard"
}

variable "api_for_lambda_execution_arn" {
  description = "Execution ARN of the API Gateway REST API"
  type        = string
}