## GF blog notification

EventBridgeで定期的にLambdaを実行し、会社の技術ブログをスクレイピングして新規記事をSlack通知するためのアプリケーションです。  
[詳細はこちらのブログを参照ください。](https://www.geekfeed.co.jp/geekblog/blog_notification_bot)

## lambdaコード

src/scraping_gf_blog
がLambda関数のセットです。

## getting start

### pythonライブラリのインストール

```shell
$ cd src/scraping_gf_blog
$ pip3 install -r requirements.txt -t ./package
```

### terraform init

```shell
$ terraform init -backend-config="profile=AWS CLIのプロファイル名"
```

### terraform plan と apply

backend.tfのprofileをデプロイしたいAWS CLIのプロファイルに変更してから実行する

## 作成者

Ippei Nishiyama

[@ippei2480](https://twitter.com/ippei2480)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
