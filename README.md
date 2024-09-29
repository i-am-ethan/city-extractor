# get-city

日本郵便のデータダウンロードからデータをダウンロードしてデータを加工する。

## 使用シーン
バッチを想定。


## Source
郵便番号データダウンロード
https://www.post.japanpost.jp/zipcode/download.html

(1)読み仮名データの促音・拗音を小書きで表記するもの(zip形式)
https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip

(2)住所の郵便番号（ローマ字・zip形式）
https://www.post.japanpost.jp/zipcode/dl/roman/KEN_ALL_ROME.zip

(3)事業所の個別郵便番号データダウンロード (zip形式)
https://www.post.japanpost.jp/zipcode/dl/jigyosyo/zip/jigyosyo.zip

## 環境構築
```
touch Dockerfile docker-compose.yml Gemfile Gemfile.lock
docker compose build
docker compose up
```