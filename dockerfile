# ベースイメージとしてNode.js 20を使用
FROM node:20

# 作業ディレクトリを設定
WORKDIR /frontend

# package.jsonとpackage-lock.jsonをコピー
COPY package*.json ./

# 依存関係をインストール
RUN npm install

# ソースコードをコピー
COPY . .

# .gitディレクトリを削除
RUN rm -rf .git/

# コンテナが使用するポートを指定
EXPOSE 3001

# 開発用のコマンドを実行
CMD [ "npm", "run", "dev" ]
