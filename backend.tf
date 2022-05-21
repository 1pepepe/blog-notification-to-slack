terraform {
  required_version = "1.1.9"
  backend "s3" {
    bucket = "tfstateファイルを保管するS3バケット名"
    key    = "tfstateファイル名を指定してください"
    region = "ap-northeast-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.11.0"
    }
  }
}

provider "aws" {
  profile = "AWS CLIのプロファイルを指定してください"
  region  = var.region
  default_tags {
    tags = var.tags
  }
}