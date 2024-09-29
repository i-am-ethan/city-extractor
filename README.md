# city-extractor

都道府県、市区町村名と郵便番号を入力すると、そのローマ字を返してくれるツール。


## 具体的にどのようにやっているか
1. 日本郵便のサイトから都道府県市区町村のデータをzipでダウンロード。
2. zipを解凍
3. csvからデータを加工して抽出
4. 引数をもとに検索

## 使用シーン
バッチを想定。


## リソース
- 郵便番号データダウンロー
https://www.post.japanpost.jp/zipcode/download.html 

- (1)読み仮名データの促音・拗音を小書きで表記するもの(zip形式)
https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip

- (2)住所の郵便番号（ローマ字・zip形式）
https://www.post.japanpost.jp/zipcode/dl/roman/KEN_ALL_ROME.zip

- (3)事業所の個別郵便番号データダウンロード (zip形式)
https://www.post.japanpost.jp/zipcode/dl/jigyosyo/zip/jigyosyo.zip

- (4)総務省｜地方行政のデジタル化｜全国地方公共団体コード
https://www.soumu.go.jp/main_content/000925835.xlsx

## 環境構築
```
touch Dockerfile docker-compose.yml Gemfile Gemfile.lock
docker compose build
docker compose up
```