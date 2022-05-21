import os
import datetime
import pytz
import certifi
import urllib.request
import requests
import json
from bs4 import BeautifulSoup
# urlopen error [SSL: CERTIFICATE_VERIFY_FAILED]を回避
import ssl
ssl._create_default_https_context = ssl._create_unverified_context

# 1時間以内に投稿された記事を取得
def check_update(url):
    now = datetime.datetime.now(pytz.timezone('Asia/Tokyo'))
    target_date = now - datetime.timedelta(hours=1)
    html = urllib.request.urlopen(url)
    soup = BeautifulSoup(html, "html.parser")
    # 記事のリスト要素を取得
    posts = soup.find(class_="blog_list").find_all("li", class_="clearfix")
    articles = []

    for post in posts:
        title = post.h3.a.string
        url = post.h3.a['href']
        author = post.find(class_="author").span.string
        # 日付をチェックするために記事の中へ
        article_html = urllib.request.urlopen(url)
        soup = BeautifulSoup(article_html, "html.parser")
        post_date_str = soup.find('meta', attrs={'property': 'article:published_time'}).get('content')
        post_date = datetime.datetime.strptime(post_date_str, "%Y-%m-%dT%H:%M:%S%fZ")
        post_date = pytz.utc.localize(post_date).astimezone(pytz.timezone("Asia/Tokyo"))
        # 日付チェック
        if post_date < target_date:
            break

        article_dict = {
            "title": title,
            "url": url,
            "author": author
        }
        articles.append(article_dict)

    return articles

# slackへ通知を行う
def send_to_slack(webhook_url, articles):
    # textを整形
    text = "ギークブログが更新されたよ:muscle::fire:\n\n"
    for article in articles:
        text += "*" + article["title"] + "*\n*"
        text += "書いた人: " + article["author"] + "*\n"
        text += article["url"] + "\n\n"

    username = "ギークブログ更新お知らせbot"
    requests.post(webhook_url, data = json.dumps({
        'text': text,
        'username': username,
        'icon_emoji': ':partying_face:',
        'link_names': 1,
    }))
    return

def main():
    url = "https://www.geekfeed.co.jp/geekblog"
    articles = check_update(url)

    if len(articles) != 0:
        webhook_url = os.environ["WEBHOOK_URL"]
        send_to_slack(webhook_url, articles)

def lambda_handler(event, context):
    print("start checking blog update...")
    main() 