## $module.design_token

全ページ共通のデザイントークンです。フェーズ2で `DESIGN.md` から生成した `theme.css`（Tailwind v4 用トークン）を、`_module_/design_token.html` に記述します。

各ページのベーステンプレートでは、`<{$module.design_token}>` として読み込まれます。

```html
<{$module.design_token}>
```

`<style type="text/tailwindcss">` タグごと `_module_/design_token.html` に記述し、その中に `theme.css` の `@theme { ... }` を貼り付けます。

### 手順

1. フェーズ2で生成した `theme.css` を開く
2. `@theme { ... }` を含む中身をすべてコピーする
3. `_module_/design_token.html` に `<style type="text/tailwindcss">` で囲んで貼り付ける

### 例

`theme.css` が以下の場合:

```css
@theme {
    --color-primary: #1a1a2e;
    --color-accent: #e94560;
    --color-base: #f5f5f5;
    --font-display: "Noto Sans JP", sans-serif;
    --radius-card: 0.75rem;
}
```

`_module_/design_token.html` は次のようになります:

```html
<style type="text/tailwindcss">
    @theme {
        --color-primary: #1a1a2e;
        --color-accent: #e94560;
        --color-base: #f5f5f5;
        --font-display: "Noto Sans JP", sans-serif;
        --radius-card: 0.75rem;
    }
</style>
```
