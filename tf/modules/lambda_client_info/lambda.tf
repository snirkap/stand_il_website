data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../src/clientInfo.py"
  output_path = "${path.module}/lambda_function_src.zip"
}

resource "aws_lambda_function" "client_info_lambda" {
  filename         = "lambda_function_src.zip"
  function_name    = var.client_info_lmabda_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "clientInfo.lambda_handler"
  runtime          = "python3.10"
  source_code_hash = data.archive_file.lambda.output_base64sha256
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "s3_write_policy" {
  name        = var.aws_iams_3_write_policy_name
  description = "Policy to allow writing to an S3 bucket and publishing messages to an SNS topic"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:PutObject",
        Resource = "arn:aws:s3:::client-info-stand-il/*"
      },
      {
        Effect   = "Allow",
        Action   = "sns:Publish",
        Resource = "arn:aws:sns:us-east-1:064195113262:MyLambdaNotificationTopic"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_write_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}

resource "aws_sns_topic" "lambda_notification_topic" {
  name = var.aws_sns_topic_name
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.lambda_notification_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.client_info_lambda.arn

  lifecycle {
  ignore_changes = [
    confirmation_timeout_in_minutes,
    endpoint_auto_confirms
  ]
  }
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.lambda_notification_topic.arn
  protocol  = "email"
  endpoint  = var.sns_topic_subscription_email
  
  lifecycle {
    ignore_changes = [
      confirmation_timeout_in_minutes,
      endpoint_auto_confirms
    ]
  }
}

