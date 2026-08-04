# デザインガイドライン

各ページの `<!-- ここをデザインする -->` の箇所を実装するときの指針です。動的な値の出力やループ・条件分岐は `smarty-reference.md` を参照してください。

## 使用技術

Tailwind（https://tailwindcss.com/） と GSAP（https://gsap.com/） を使用します。ベーステンプレートで CDN を読み込み済みのため、ページ側で再度読み込む必要はありません。Tailwind はブラウザ版（`@tailwindcss/browser`）を `<head>` で、GSAP は `</body>` の直前で読み込みます。

```html
<!-- ベーステンプレートで読み込み済み（再記述不要） -->
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.15/dist/gsap.min.js"></script>
```

## デザイントークンを使う

色・フォント・角丸などは、必ず `<{$module.design_token}>` で定義したデザイントークンを使います。`@theme` のトークンは Tailwind のユーティリティクラスになります。`#1a1a2e` のような生のカラーコードや任意値（`bg-[#1a1a2e]`）を直接書かないでください。トークンを使うことで全ページのデザインが揃います。

| トークン | ユーティリティクラスの例 |
| --- | --- |
| `--color-primary` | `bg-primary` / `text-primary` / `border-primary` |
| `--color-accent` | `bg-accent` / `text-accent` |
| `--color-base` | `bg-base` |
| `--font-display` | `font-display` |
| `--radius-card` | `rounded-card` |

**良い例**

```html
<button class="bg-accent text-base font-display rounded-card px-6 py-3">
  カートに入れる
</button>
```

**避ける例**（トークンを使っていない）

```html
<button class="bg-[#e94560] text-white rounded-[0.75rem] px-6 py-3">
  カートに入れる
</button>
```

## レイアウトとレスポンシブ

モバイルファーストで実装します。まずスマートフォン向けのスタイルを書き、`sm:` `md:` `lg:` のプレフィックスで画面が広いときの差分を足します。ブレークポイントは `sm`=640px / `md`=768px / `lg`=1024px / `xl`=1280px です。

コンテンツ幅は `max-w-*` と `mx-auto`、左右の余白 `px-*` で中央寄せします。

```html
<section class="mx-auto max-w-7xl px-4 py-12 md:px-6 md:py-20">
  <h2 class="font-display text-2xl md:text-3xl">おすすめ商品</h2>
</section>
```

商品一覧などのカードは Grid で並べ、画面幅に応じて列数を変えます。

```html
<div class="grid grid-cols-2 gap-4 md:grid-cols-3 lg:grid-cols-4">
  <!-- 商品カード -->
</div>
```

## 余白とタイポグラフィ

余白はTailwindのスペーシングスケール（`4`=1rem 単位）に揃え、近い値を場当たり的に混ぜないでください。セクション間は `py-12 md:py-20`、要素間は `gap-4` / `space-y-6` のように一定のリズムを保ちます。見出しには `font-display` を使い、`text-3xl` → `text-xl` → `text-base` のように階層が一目で分かるサイズ差をつけます。

## アニメーション（GSAP）

ページ固有のスクリプトは `</body>` 直前（GSAP 読み込み後）に `<script>` で記述します。

```html
<script>
  gsap.from(".js-reveal", {
    opacity: 0,
    y: 24,
    duration: 0.6,
    ease: "power2.out",
    stagger: 0.1,
  });
</script>
```

## 画像

メインビジュアルは被写体が中央に収まる高解像度の横長画像を用意し、商品一覧では背景・明るさ・被写体の比率を揃えると整然と見えます。画像は `object-cover` と `aspect-*` で表示比率を固定し、レイアウト崩れを防ぎます。`alt` には何の画像かが分かる説明を入れ、ファーストビュー以外の画像には `loading="lazy"` を付けます。

```html
<img
  src="<{$item.image}>"
  alt="<{$item.name}>"
  class="aspect-square w-full rounded-card object-cover"
  loading="lazy"
>
```

## セマンティックなマークアップ

`header` / `main` / `nav` / `section` / `footer` などの要素で構造を示します。`h1` はページに1つだけ置き、見出しレベルを飛ばさずに使います。リンク遷移は `a`、操作は `button` と用途で使い分けます。装飾だけの要素に意味を持たせないようにします。
