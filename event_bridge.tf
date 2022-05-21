resource "aws_cloudwatch_event_rule" "scraping_gf_blog_lambda_event_rule" {
  name                = "scraping-gf-blog-lambda-event-rule"
  description         = "毎時0分にscraping_gf_blog lambdaを実行"
  schedule_expression = "cron(0 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "scraping_gf_blog_lambda_target" {
  arn  = module.scraping_gf_blog_lambda.lambda_function_arn
  rule = aws_cloudwatch_event_rule.scraping_gf_blog_lambda_event_rule.name
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_rw_fallout_retry_step_deletion_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.scraping_gf_blog_lambda.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.scraping_gf_blog_lambda_event_rule.arn
}
