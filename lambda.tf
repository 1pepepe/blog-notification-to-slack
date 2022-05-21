module "scraping_gf_blog_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "3.2.0"
  # insert the 32 required variables here

  function_name = "scraping_gf_blog"
  description   = "My awesome lambda function"
  handler       = "scraping_gf_blog.lambda_handler"
  runtime       = "python3.9"
  memory_size   = 128
  timeout       = 10
  architectures = ["arm64"]

  environment_variables = {
    WEBHOOK_URL = "SlackのWebHook URLを指定してください"
  }

  source_path = "./src/scraping_gf_blog"

  tags = {
    Name = "scraping_gf_blog"
  }
}
