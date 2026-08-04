# 商品レビュー一覧ページ

任意

## 実装手順

1. テンプレートを作業フォルダの `standard/html/review-list.html` にコピーする。使用しているレビュー機能によってコピー元が異なる。
   - 旧レビューの場合: `templates/standard/html/review-list.html`
   - 新レビュー（U-KOMI）の場合: `templates/standard/html/review-list-ukomi.html`

2. 必要なパーツを洗い出す。

3. コピーしたファイルの `<!-- ここをデザインする -->` の箇所に、design-referenceとsmarty-referenceを使用してコーディングする。

## デザインポイント

レビューを並べるだけでなく、信頼感を伝える見せ方の工夫を挙げる。

### レビューの実装

レビュー機能は、新レビュー（U-KOMI）と旧レビューのどちらを使用しているかで実装方法が異なる。実装前に必ずどちらを使用しているかをユーザーにヒアリングする。

新レビュー（U-KOMI）を使用している場合は、テンプレート `templates/standard/html/review-list-ukomi.html` をベースにする。以下の全商品のレビュー一覧表示タグが設置済みで、全商品のレビューとショップレビューを1つのページにまとめて表示できる。

```html
<div class="review-container" data-action="dedicated-widget" data-product-picture="1"></div>
```

### 評価を象徴的に見せる

平均評価と件数を大きく星で見せ、店全体の評価を一目で伝える。

### 声を魅せるレイアウト

レビューをカードや吹き出しで見せ、高評価のコメントを引用のように際立たせると、読ませる説得力が出る。

## チェックリスト

実装が終わったら動作をセルフチェック、ユーザーにも確認してください。
