# ベースイメージとして公式のRubyイメージを使用
FROM ruby:3.2

# 必要なLinuxパッケージのインストール
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# アプリケーションディレクトリを作成
WORKDIR /app

# ソースコードとスクリプトをコピー
COPY . /app
RUN chmod +x /app/install.sh

# デフォルトのコマンドをinstall.shの実行に変更
CMD ["sh", "/app/install.sh"]