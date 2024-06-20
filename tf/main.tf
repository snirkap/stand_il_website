module "s3_bucket" {
  source = "./modules/s3_website"
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
}

module "cloudfront" {
  source = "./modules/cloudfront"
  s3_bucket_id = module.s3_bucket.s3_bucket_id
  s3_bucket_domain_name = module.s3_bucket.s3_bucket_bucket_domain_name
}

module "s3_backups_bucket" {
  source = "./modules/s3_state_backups"
}

module "route53" {
  source = "./modules/route53"
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
}

module "s3_client_info" {
  source = "./modules/s3_client_info"
}

module "lambda_client_info" {
  source = "./modules/lambda_client_info"
}

module "api_gateway" {
  source = "./modules/api_gateway"
  client_info_lambda_invoke_arn = module.lambda_client_info.client_info_lambda_invoke_arn
  client_info_lambda_function_name = module.lambda_client_info.client_info_lambda_function_name
  button_click_lambda_invoke_arn = "arn:aws:lambda:us-east-1:064195113262:function:ButtonClickLambda"
  iam_for_lambda_name = module.lambda_client_info.iam_for_lambda_name
  client_info_lambda_arn = module.lambda_client_info.client_info_lambda_arn
}

module "lambda_for_metrics" {
  source = "./modules/lambda_for_metrics"
  api_for_lambda_execution_arn = module.api_gateway.api_for_lambda_execution_arn
}