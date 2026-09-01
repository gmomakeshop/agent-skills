# トラブルシューティング

デザイン中によく遭遇する不具合と対処法です。

## クリエイターモードにインポートした後のページ表示が遅い

**このページ高速化の手順は、ユーザーから「ページの読み込みが遅い」と指摘があった場合にのみ実施します。** 通常はブラウザ版 CDN（`@tailwindcss/browser`）のままで問題ありません。

原因は、ブラウザ版 Tailwind（`@tailwindcss/browser`）が**ページを開くたびにブラウザ上で CSS をコンパイルする**ことです。CLI であらかじめ CSS をビルドし、ビルド済み CSS を読み込むように切り替えると解消します。

### 手順

作業フォルダ（例：`new_design_set/`）で、その時点で存在する全ページ・全モジュールをまとめて 1 本の CSS にビルドし、専用モジュール `_module_/tailwind.html` に入れて全ページ共通で読み込みます。

1. ビルド用の入力 CSS（例：`tailwind.input.css`）を作業フォルダに用意します。Tailwind 本体の読み込み、フェーズ2で生成した `theme.css`（`@theme` トークン）、走査対象の指定を記述します。ビルド結果を入れる `_module_/tailwind.html` 自身は走査対象から除外します（古いユーティリティが残り続けるのを防ぐため）。

    ```css
    @import "tailwindcss";
    @import "./theme.css";
    @source "./standard/html";
    @source "./_module_";
    @source not "./_module_/tailwind.html";
    ```

2. Tailwind CLI でビルドします。`--minify` で圧縮します。`npx` の初回実行でインストール確認が出た場合は許可して進めます。

    ```bash
    npx @tailwindcss/cli@latest -i tailwind.input.css -o tailwind.output.css --minify
    ```

3. 生成された `tailwind.output.css` の中身を、`<style>` で囲んで `_module_/tailwind.html` に貼り付けます。`@theme` のトークンもこの CSS へ焼き込まれます。

    ```html
    <style>
    /* tailwind.output.css の中身をそのまま貼り付ける */
    </style>
    ```

4. `config.json` の `module` に `tailwind` を追記します。

5. 各ページの `<head>` を書き換えます。ブラウザ版 CDN の読み込みを削除し、`design_token` の読み込みをビルド済みモジュールに差し替えます（トークンはビルド CSS に含まれるため `design_token` は不要になります）。

    ```html
    <!-- 削除する -->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <{$module.design_token}>

    <!-- 追加する -->
    <{$module.tailwind}>
    ```

6. 以降、ページを追加・修正して新しいユーティリティクラスを使ったら、必ず再ビルドして `_module_/tailwind.html` を更新します。更新を忘れると、そのクラスの CSS が出力されず崩れます。

## EUC-JP 変換で特定の文字が弾かれる

`.cdar` 生成時の EUC-JP 変換（`iconv`）で、EUC-JP に存在しない文字が含まれるとエラーになります。

- **絵文字（🛒 ☺ など）は EUC-JP に存在しないため弾かれます。** 数値文字参照（`&#x1F6D2;` のように書く）に置き換えるか、ベーステンプレートで読み込み済みの Font Awesome のアイコン（`<i class="fas fa-shopping-basket"></i>`）に置き換えてください。
- **en dash `–`（U+2013）は `iconv` で弾かれます。** 波ダッシュ `〜` やハイフン `-` に置き換えてください。
- em dash `—`（U+2014）は EUC-JP に含まれるため通ります。
