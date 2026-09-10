---
name: creator-mode-design
description: makeshop byGMOでショップデザインを行うスキル。クリエイターモードというデザインモードを使用している場合に使用する。「クリモでデザインしたい」「クリモのコードを生成したい」「ショップデザインをしたい」などをトリガーに起動する。
---

# クリエイターモードデザインスキル

makeshop byGMOでショップデザインを行うスキル。

## クリエイターモードデザインファイル構成

```text
.
├── config.json                         デザインセットの設定。レスポンシブ対応、モジュール一覧、フリーページ定義を持つ（必須）
├── _module_/                           makeshopがデフォルトで用意している各ページとショップ様が自由に追加できるページから <{$module.xxx}> で呼び出せるモジュール
│   ├──  header.html                    全ページ共通のヘッダー。HTMLの定義のみ。CSS、JavaScriptは定義できない。（必須）
│   ├──  footer.html                    全ページ共通のフッター。HTMLの定義のみ。CSS、JavaScriptは定義できない。（必須）
│   ├──  design_token.html              全ページ共通のデザイントークン。HTMLの定義のみ。CSS、JavaScriptは定義できない。（必須）
│   └──  xxx.html                       任意のパーツ。HTMLの定義のみ。CSS、JavaScriptは定義できない。
└── standard/                           
    ├── html/                           makeshopがデフォルトで用意している各ページのHTML
    │   ├── bulk.html                   まとめ買い割引ページのHTML
    │   ├── cart.html                   買い物カゴページのHTML（必須）
    │   ├── catalog.html                カタログページのHTML
    │   ├── category.html               商品カテゴリーページのHTML（必須）
    │   ├── company.html                会社概要ページのHTML（必須）
    │   ├── contract.html               特定商取引法ページのHTML（必須）
    │   ├── guide.html                  利用案内ページのHTML（必須）
    │   ├── item.html                   商品詳細ページのHTML（必須）
    │   ├── news-detail.html            お知らせ詳細ページのHTML
    │   ├── news-list.html              お知らせ一覧ページのHTML
    │   ├── policy.html                 プライバシーポリシーページのHTML（必須）
    │   ├── review-list.html            商品レビュー一覧ページのHTML
    │   ├── review-post.html            商品レビュー投稿ページのHTML
    │   ├── search.html                 商品検索結果ページのHTML（必須）
    │   ├── top.html                    トップページのHTML（必須）
    │   └── verification.html           会員制／年齢確認ページのHTML
    ├── css/                            makeshopがデフォルトで用意しているページのCSS
    │   ├── bulk.css                    まとめ買い割引ページのCSS
    │   ├── cart.css                    買い物カゴページのCSS
    │   ├── catalog.css                 カタログページのCSS
    │   ├── category.css                商品カテゴリーページのCSS
    │   ├── company.css                 会社概要ページのCSS
    │   ├── contract.css                特定商取引法ページのCSS
    │   ├── guide.css                   利用案内ページのCSS
    │   ├── item.css                    商品詳細ページのCSS
    │   ├── news-detail.css             お知らせ詳細ページのCSS
    │   ├── news-list.css               お知らせ一覧ページのCSS
    │   ├── policy.css                  プライバシーポリシーページのCSS
    │   ├── review-list.css             商品レビュー一覧ページのCSS
    │   ├── review-post.css             商品レビュー投稿ページのCSS
    │   ├── search.css                  商品検索結果ページのCSS
    │   ├── top.css                     トップページのCSS
    │   └── verification.css            会員制／年齢確認ページのCSS
    ├── javascript/                     makeshopがデフォルトで用意している各ページのJavaScript
    │   ├── bulk.js                     まとめ買い割引ページのJavaScript
    │   ├── cart.js                     買い物カゴページのJavaScript
    │   ├── catalog.js                  カタログページのJavaScript
    │   ├── category.js                 商品カテゴリーページのJavaScript
    │   ├── company.js                  会社概要ページのJavaScript
    │   ├── contract.js                 特定商取引法ページのJavaScript
    │   ├── guide.js                    利用案内ページのJavaScript
    │   ├── item.js                     商品詳細ページのJavaScript
    │   ├── news-detail.js              お知らせ詳細ページのJavaScript
    │   ├── news-list.js                お知らせ一覧ページのJavaScript
    │   ├── policy.js                   プライバシーポリシーページのJavaScript
    │   ├── review-list.js              商品レビュー一覧ページのJavaScript
    │   ├── review-post.js              商品レビュー投稿ページのJavaScript
    │   ├── search.js                   商品検索結果ページのJavaScript
    │   ├── top.js                      トップページのJavaScript
    │   └── verification.js             会員制／年齢確認ページのJavaScript
    └── freepage/                       ショップ様が自由に追加できるページ
        └── xxx.html                    HTMLの定義のみ。CSS、JavaScriptは定義できない。
```

## セットアップ

デザインを始める前に、Node.js・ブラウザ操作ツール・MCP サーバーを設定します。設定手順は `references/setup-reference.md` を参照してください。

## デザイン手順

このスキルは次の4フェーズを **必ずこの順番で** 実行します。各フェーズは前のフェーズの成果物を入力にするため、途中を飛ばすと後段が成立しません。

**全ページを一度に作成してはいけません。** まず最初の1ページだけを作成して `.cdar` を生成し、デザインの方向性をユーザーに確認してもらいます。最初に作成するページは、ユーザーが希望するページから始められます。特に希望がなければトップページから始めるのがおすすめです。最初のページのデザインで問題がなければ、残りのページを **1ページずつ** 作成していきます。こうすることで、方向性がずれたまま全ページを作り込んで大きく後戻りする事態を防ぎます。

各フェーズの詳細は以下の通りです。

### フェーズ1: 方針決め

1. 何をデザインするかを決めます。ショップの全ページを実装したいのか、一部のページだけを実装したいのか、もしくは既存のページを編集したいのかなど、何をデザインしたいのかを決めます。あわせて、**どのページから作り始めるか**（デザインの方向性を最初に確認するページ）も決めます。ユーザーに希望があればそのページから、特に希望がなければトップページから始めます。

2. どんなデザインにしたいのかを決めます。近づけたいサイトやイメージがあれば提供してもらいます。もし明確に決まっていない場合は、まずは商品情報を取得しショップのイメージを把握した上で、デザインを提案します。それでも難しい場合は、ショップ名やターゲット層、コンセプトなどをヒアリングした上で、デザインを提案します。

### フェーズ2: DESIGN.md の作成

次のクリエイターモードデザインファイルの作成に進む前に、必ず `DESIGN.md` と `theme.css` の両方を生成し終えてください。

Node.js を用意していない場合は、手順2・3の `npx` を実行できません。その場合は `DESIGN.md` を手動で作成し、`theme.css` も手動で書き出してください。

1. `https://github.com/google-labs-code/design.md` を参考に、`DESIGN.md` を作成します。フェーズ1で決定したデザイン方針（色・フォント・余白・角丸・トーンなど）が反映されるように記述します。

2. `npx @google/design.md@latest lint DESIGN.md` を実行して、lint を行います。エラーが発生した場合は内容を確認し、エラーがなくなるまで修正してください。`npx` の初回実行で `@google/design.md` のインストール確認が出た場合は許可して進めます。

3. `npx @google/design.md@latest export --format css-tailwind DESIGN.md > theme.css` を実行して、Tailwind v4 用にデザイントークンを `theme.css` にエクスポートします。この `theme.css` を次のフェーズで `_module_/design_token.html` および各ページに差し込みます。

### フェーズ3: 最初のページの作成と確認

このフェーズでは **フェーズ1で決めた最初のページとその表示に必要な共通パーツだけ** を作成し、`.cdar` を生成してデザインの方向性をユーザーに確認してもらいます。他のページはまだ作成しません。

以降の説明では、フェーズ1で決めた最初のページを「対象ページ」と呼びます。対象ページの HTML ファイルと固有リファレンスは、後述の「ページとリファレンスの対応表」から特定します（例：トップページなら `standard/html/top.html` と `references/page-reference-top.md`、商品詳細ページなら `standard/html/item.html` と `references/page-reference-item.md`）。

1. 作業フォルダを作成します。任意の名前でOKです。
  - 例：`new_design_set/`

2. 対象ページの表示に必要なファイルを、`クリエイターモードデザインファイル構成` に従って作業フォルダに配置してコーディングします。HTML・モジュールの実装は共通して `references/design-reference.md` に従い、ファイルごとに以下の固有リファレンスを併せて参照します。
  1. まずは、`_module_/`にデザイントークンを定義します。フェーズ2で生成した `theme.css` の内容を使い、`references/module-reference-design-token.md` を参照します。
  2. 次に、`_module_/`にヘッダー（`references/module-reference-header.md`）、フッター（`references/module-reference-footer.md`）、そのほか対象ページで必要なパーツを定義します。
  3. 次に対象ページ本体（例：`standard/html/top.html`）を定義します。固有リファレンスは「ページとリファレンスの対応表」で対象ページに対応するものを参照します。
  4. 最後に `config.json` を定義します。`references/config-json-reference.md` を参照し、この時点では `_module_/` に定義したモジュールだけを記述します。

3. コードを書き終えたら、「Smarty → HTML 変換とローカルプレビュー」の手順に従って、Smarty で書いたコードをプレビュー用の HTML に変換し、手元のブラウザでプレビューしてデザイン崩れがないかを必ず確認します。崩れがあれば修正してから次に進みます。

4. 「`.cdar` への圧縮とインポート」の手順に従って `.cdar` を生成し、ユーザーに管理画面でインポートしてもらって対象ページのデザインの方向性を確認してもらいます。

5. 修正要望があれば DESIGN.md（必要に応じて `theme.css` の再エクスポート）や対象ページに反映し、再度プレビューでデザイン崩れがないかを確認してから `.cdar` を生成します。**デザインの方向性が確定するまで、フェーズ4には進みません。**

### フェーズ4: 残りのページを1ページずつ作成

最初のページのデザインが確定したら、他のページを **1ページずつ** 作成していきます。一度に複数ページをまとめて作成せず、1ページ作るごとに必要に応じて `.cdar` を生成して確認できるようにします。

各ページは、フェーズ3で確定したデザイントークン・共通パーツ・最初のページのトーンに揃えて定義します。フェーズ3と同様、HTML の実装は共通して `references/design-reference.md` に従い、ページごとに後述の「ページとリファレンスの対応表」の固有リファレンスを併せて参照します。**フェーズ3で作成済みのページは除き、残りのページを作成します。**

各ページの作成手順は次の通りです。

1. 上記の対応するリファレンスに従って、対象ページを1ページ作成します。
2. ページの作成にあたり新しいモジュールを追加した場合は、`config.json` にそのモジュールを追記します。
3. 必要であれば `freepage` に任意のページを定義します。`references/design-reference.md` に従って実装し、`config.json` の `freepage` に追記してください。
4. コードを書き終えたら、「Smarty → HTML 変換とローカルプレビュー」の手順に従って、Smarty で書いたコードをプレビュー用の HTML に変換し、手元のブラウザでプレビューしてデザイン崩れがないかを必ず確認します。崩れがあれば修正してから次に進みます。
5. 「`.cdar` への圧縮とインポート」の手順に従って `.cdar` を生成し、ユーザーに確認してもらいます。問題なければ次のページに進みます。

全ページを作り終えたら、`config.json` にすべてのモジュール・フリーページが反映されているか最終確認してください。

### ページとリファレンスの対応表

フェーズ3の最初のページ、フェーズ4の残りのページのいずれでも、対象ページの HTML ファイルと固有リファレンスは以下から特定します。

- `standard/html/top.html` — `references/page-reference-top.md`
- `standard/html/bulk.html` — `references/page-reference-bulk.md`
- `standard/html/cart.html` — `references/page-reference-cart.md`
- `standard/html/catalog.html` — `references/page-reference-catalog.md`
- `standard/html/category.html` — `references/page-reference-category.md`
- `standard/html/company.html` — `references/page-reference-company.md`
- `standard/html/contract.html` — `references/page-reference-contract.md`
- `standard/html/guide.html` — `references/page-reference-guide.md`
- `standard/html/item.html` — `references/page-reference-item.md`
- `standard/html/news-detail.html` — `references/page-reference-news-detail.md`
- `standard/html/news-list.html` — `references/page-reference-news-list.md`
- `standard/html/policy.html` — `references/page-reference-policy.md`
- `standard/html/review-list.html` — `references/page-reference-review-list.md`
- `standard/html/review-post.html` — `references/page-reference-review-post.md`
- `standard/html/search.html` — `references/page-reference-search.md`
- `standard/html/verification.html` — `references/page-reference-verification.md`

### Smarty → HTML 変換とローカルプレビュー

フェーズ3・フェーズ4の両方で使用する共通手順です。コードを書き終えたら、`.cdar` を生成する前に必ずこの手順でデザイン崩れがないかを手元で確認します。クリエイターモードのコードは Smarty で書かれており、独自タグ（`<{$...}>`）やループ・条件分岐をそのままブラウザで開いても描画されないため、プレビュー用に静的な HTML へ書き換えてから確認します。

1. プレビュー用の一時フォルダ（例：`.preview/`）に、確認したいページと共通パーツをコピーします。編集中のファイル（`new_design_set/`）は Smarty のまま保持し、コピーしたファイルだけを書き換えます。

2. クリエイターモードのタグリファレンスと `references/smarty-reference.md` の「クリエイターモードのタグの置換例」（各節の **Smarty** と **出力されるHTML** の対応）を参考に、Smarty を静的な HTML へ書き換えます。タグの意味やどんな値が出力されるかは、まず MCP サーバーのタグリファレンスから取得し、取得できない場合は公式のウェブのタグリファレンス（https://reference.makeshop.jp/creator-mode/contents/common/index.html）から確認します。

3. 商品名・価格・画像・商品一覧など、商品に関わるタグを静的な HTML に書き換えるときは、**架空のダミーデータではなく、ショップに登録されている実際の商品を取得して使用します**。実データ（商品名・価格・商品画像・在庫状況など）を差し込むことで、実際の見え方に近い状態でデザイン崩れを確認できます。商品が取得できない場合に限り、リファレンスの置換例のようなダミーデータで代替します。

4. 書き換えた HTML を手元のブラウザで開いてプレビューし、レイアウト・余白・色・フォント・レスポンシブ表示などにデザイン崩れがないかを必ず確認します。

### `.cdar` への圧縮とインポート

フェーズ3・フェーズ4の両方で使用する共通手順です。`.cdar` を生成したいタイミングで以下を実行します。

スクリプトはこのスキルの `scripts/` にあります。作業フォルダ（`new_design_set/`）の親で実行し、引数に作業フォルダを渡します。以降の例では `<スキル>` をこのスキルのパスに読み替えてください。

1. `build.sh` で `.cdar` を生成する。EUC-JP に変換して圧縮し、カレントフォルダに `new_design_set.cdar` を作ります。

    ```bash
    bash <スキル>/scripts/build.sh new_design_set
    ```

    Windows では PowerShell 版を使います。

    ```bash
    powershell -NoProfile -ExecutionPolicy Bypass -File <スキル>/scripts/build.ps1 new_design_set
    ```

    エラーが出た場合は `.cdar` を生成せずに終了します。以下のとおり修正して、生成できるまで繰り返します。

    - `EUC-JP に変換できない文字があります` … 表示されたファイルの文字を EUC-JP で表現できる文字に置き換えます。どの文字が使えないか・何に置き換えるかは `references/troubleshooting.md` を参照してください。
    - `config.json は UTF-8 で保存してください` … `config.json` を UTF-8 で保存し直します。

2. 生成した `new_design_set.cdar` ファイルを管理画面からインポートする

### （任意）クリエイターモードのプレビュー確認

`.cdar` をインポートした後、ユーザーに希望があれば、クリエイターモード上の実際のプレビューをブラウザで確認します。ローカルプレビューは Smarty を静的な HTML に書き換えた近似であるため、実データが反映された本物のプレビューでデザイン崩れがないかを最終確認できます。

1. インポートした `.cdar` をクリエイターモードに反映する。
2. 対象のページをクリエイターモード上でプレビューする。
3. ユーザーにそのプレビューの URL を共有してもらう。
4. 提供された URL をブラウザで開いて表示を確認する。
5. デザイン崩れ等があれば修正し、再度 `.cdar` を生成してプレビューを確認する。
