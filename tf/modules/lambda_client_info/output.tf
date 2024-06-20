output "client_info_lambda_arn" {
  value = aws_lambda_function.client_info_lambda.arn
}

output "client_info_lambda_function_name" {
  value = aws_lambda_function.client_info_lambda.function_name
}

output "iam_for_lambda_name" {
  value = aws_iam_role.iam_for_lambda.name
}

output "client_info_lambda_invoke_arn" {
  value = aws_lambda_function.client_info_lambda.invoke_arn
}