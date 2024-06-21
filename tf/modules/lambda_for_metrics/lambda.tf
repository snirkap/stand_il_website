data "archive_file" "lambda_metric" {
    type = "zip"
    source_file = "${path.module}/../src/metricClick.py"
    output_path = "metricClick.zip"
}

resource "aws_lambda_function" "button_click_lambda" {
  filename         = "metricClick.zip"
  function_name    = var.button_click_lambda_name
  role             = aws_iam_role.iam_for_lambda_metric.arn
  handler          = "metricClick.lambda_handler"
  runtime          = "python3.8"
  timeout          = 10
  memory_size      = 128 
  source_code_hash = data.archive_file.lambda_metric.output_base64sha256
}

resource "aws_iam_role" "iam_for_lambda_metric" {
  name = var.iam_for_lambda_metric_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "cloudwatch_policy" {
    name        = var.cloudwatch_policy_name
    description = "Allows putting metrics to CloudWatch and getting metric data"
    policy      = jsonencode({
        Version   = "2012-10-17"
        Statement = [
            {
                Effect   = "Allow"
                Action   = "cloudwatch:PutMetricData"
                Resource = "*"
            },
            {
                Effect   = "Allow"
                Action   = "cloudwatch:GetMetricData"
                Resource = "*"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "lambda_metric" {
    policy_arn = aws_iam_policy.cloudwatch_policy.arn
    role       = aws_iam_role.iam_for_lambda_metric.name
}

resource "aws_lambda_permission" "apigw_lambda_metric" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.button_click_lambda.arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${var.api_for_lambda_execution_arn}/*/*/*"
}

resource "aws_cloudwatch_dashboard" "button_click_dashboard" {
  dashboard_name = var.cloudwatch_dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x    = 0,
        y    = 0,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            ["countClickButton", "ButtonClickedCount", "Button", "Home", { "region": "us-east-1" }],  
            ["countClickButton", "ButtonClickedCount", "Button", "Gallery", { "region": "us-east-1" }],
            ["countClickButton", "ButtonClickedCount", "Button", "Assemble", { "region": "us-east-1" }],    
          ],
        "view": "bar",
        "region": "us-east-1",
        "legend": {
            "position": "right"
          },
        "stat": "Sum",
        "period": 60,
        "liveData": true,
        "stacked": true,
        "setPeriodToTimeRange": true
        }
      }
    ]
  })
}

