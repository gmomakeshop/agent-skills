# 商品詳細ページ

必須

## 実装手順

1. テンプレート `templates/standard/html/item.html` を作業フォルダの `standard/html/item.html` にコピーする。

2. 必要なパーツを洗い出す。

3. コピーしたファイルの `<!-- ここをデザインする -->` の箇所に、design-referenceとsmarty-referenceを使用してコーディングする。

## デザインポイント

商品名・価格・カゴボタンを並べるだけでなく、商品の魅力が伝わる見せ方を作り込む。以下は商品を魅力的に見せる工夫の例。

### 大きなビジュアルで世界観を伝える

ファーストビューに大きなメイン画像を据え、商品の第一印象を決める。画像の左右に余白やテキストを添えたり、画像と説明文を交互に組むことで、雑誌のように読ませる構成にできる。

### スクロールで読ませるストーリー

スクロールに連動して画像とテキストが切り替わる構成で、商品のコンセプトや開発背景を物語のように体験させる。

### 購入導線を常に届く位置に

魅力を伝えるリッチな構成でも、価格とカゴボタンは見失わせない。スクロール追従や要所への再掲で、買いたくなった瞬間に押せるようにする。

### レビューの実装

レビュー機能は、新レビュー（U-KOMI）と旧レビューのどちらを使用しているかで実装方法が異なる。実装前に必ずどちらを使用しているかをユーザーにヒアリングする。

新レビュー（U-KOMI）を使用している場合は、以下のタグを設置する。

スターレーティング（星の5段階評価）を表示するタグ:

```html
<div class="review-summary-container" data-gname="<{$item.system_code}>" data-pid="<{$item.system_code}>" data-group="true" data-action="summary"></div>
```

レビュー一覧・レビュー投稿ボタンを表示するタグ（商品詳細の下部に置くと、ページ遷移せずにレビューを読める）:

```html
<div class="review-container" data-gname="<{$item.system_code}>" data-pid="<{$item.system_code}>" data-group="true" data-action="widget"></div>
```

関連商品（商品グループ）の各商品にスターレーティングを表示するタグ:

```html
<div class="review-summary-container" data-gname="<{$item.group.list[i].system_code}>" data-pid="<{$item.group.list[i].system_code}>" data-group="true" data-popup="false" data-action="summary"></div>
```

注意: U-KOMIのタグは、旧レビュー機能の有効判定である `<{if $review_item.is_enabled}>` のようなif文の外に設置する。if文の中に置くと、旧レビュー機能を無効化した際にU-KOMIのレビューも表示されなくなる。

## チェックリスト

実装が終わったら動作をセルフチェック、ユーザーにも確認してください。以下はチェックすべき項目の一例です。

- カートに追加できるか
