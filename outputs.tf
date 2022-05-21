output "eventbridge_rule_arns" {
  description = "The EventBridge Rule ARNs"
  value       = aws_cloudwatch_event_rule.scraping_gf_blog_lambda_event_rule.arn
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = module.scraping_gf_blog_lambda.lambda_function_arn
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = module.scraping_gf_blog_lambda.lambda_function_name
}