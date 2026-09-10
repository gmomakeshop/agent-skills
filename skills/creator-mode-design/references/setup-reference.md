# セットアップリファレンス

デザインを始める前に、以下を設定します。

## 【推奨】makeshop byGMO MCP サーバー

ショップの実際の商品データの取得と、クリエイターモードのタグリファレンスの参照に使います。

### 確認

makeshop byGMO MCP サーバーが登録済みかつ認証済みで、`creator_mode_tag_reference` が使用できれば問題ございません。

## 【推奨】ブラウザ操作ツール

プレビュー確認で、ローカルの HTML ファイルとクリエイターモードのプレビュー URL を開きます。Claude in Chrome、ChatGPT for Chrome、Computer Use など、AI がブラウザを操作できるものであれば種類は問いません。

### 確認

https://www.makeshop.jp/ を開ければ問題ございません。

## 【任意】Node.js

フェーズ2で `npx @google/design.md@latest` を実行します。インストールしない場合は、`DESIGN.md` の作成と `theme.css` へのエクスポートを手動で行います。

### 確認

バージョン18以上がインストールされていれば問題ございません。

```bash
node -v
```
