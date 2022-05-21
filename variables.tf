variable "region" {
  description = "Deploy region"
  default     = "ap-northeast-1"
}

variable "tags" {
  description = "すべてのリソースに追加するタグ"
  type        = map(string)
  default = {
    "application" = "gf-blog-notiofication",
    "Owner"       = "nishiyama"
  }
}