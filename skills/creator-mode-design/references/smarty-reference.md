# Smarty コーディングガイドライン

クリエイターモードのHTMLはテンプレートエンジン **Smarty** で記述します。HTML の中に `<{ ... }>` を埋め込み、変数の出力・条件分岐・繰り返しなどを行います。

## デリミタ

デリミタは通常のSmartyの`{ }`ではなく、`<{ }>`で記述します。`<{* *}>`で記述するとコメントとして扱われます。

**Smarty**

```html
<{* これはコメント。出力されない *}>
<p><{$shop.name}></p>
```

**出力されるHTML**

```html
<p>サンプルショップ</p>
```

## 独自タグの出力

`$` を付けて参照し、`<{$変数}>` で値を出力します。

各ページで使用できる独自タグの一覧と意味は、クリエイターモードのタグリファレンスを参照してください。

タグリファレンスはMCPサーバーとウェブで配信しています。まずはMCPサーバーから取得し、取得できない場合はウェブ（https://reference.makeshop.jp/creator-mode/contents/common/index.html）から取得してください。

**Smarty**

```html
<title><{$page.title}></title>
```

**出力されるHTML**

```html
<title>新着アイテム特集</title>
```

## 修飾子

変数にパイプ `|` を付けると値を加工できます。

### number_format

数値を3桁区切りにします。

**Smarty**

```html
<p><{$item.price|number_format}>円</p>
```

**出力されるHTML**

```html
<p>1,234円</p>
```

### count

配列の要素数を返します。

**Smarty**

```html
<p>全 <{$products.list|count}> 件</p>
```

**出力されるHTML**

```html
<p>全 3 件</p>
```

### nl2br

改行を `<br>` に変換します。

**Smarty**

```html
<p><{$item.note|nl2br}></p>
```

**出力されるHTML**

```html
<p>1行目<br>2行目</p>
```

### escape

`&"'<>` をHTMLエスケープします。ユーザー入力など、HTMLとして解釈させたくない値に使います。

**Smarty**

```html
<p><{$comment|escape}></p>
```

**出力されるHTML**

```html
<p>&lt;script&gt;</p>
```

### cut_html

HTMLタグを除去し、指定した文字数で切り取ります。文字数はコロン `:` で区切って渡します。

**Smarty**

```html
<p><{$item.description|cut_html:10}></p>
```

**出力されるHTML**

```html
<p>ふんわり軽い着心地の</p>
```

## 条件分岐
`<{if}>` `<{elseif}>` `<{else}>` `<{/if}>` を使います。終了タグ `<{/if}>` を必ず書いてください。

**Smarty**

```html
<{if $products.list.size > 0}>
  <p>商品が <{$products.list.size}> 件あります</p>
<{elseif $keyword != ""}>
  <p>「<{$keyword}>」に一致する商品はありません</p>
<{else}>
  <p>商品がありません</p>
<{/if}>
```

## 繰り返し

配列を繰り返すには `<{section}>` または `<{foreach}>` を使います。終了タグ（`<{/section}>` / `<{/foreach}>`）を必ず書いてください。

### section を使う場合

`<{section}>` は連番のインデックスで配列を回します。`name` にループ変数名、`loop` に対象配列、`max` に最大繰り返し回数（省略可）を指定し、要素には `配列[name]` でアクセスします。

**Smarty**

```html
<{section name=i loop=$products.list max=10}>
  <div class="item">
    <a href="<{$products.list[i].url}>">
      <p class="name"><{$products.list[i].name}></p>
      <p class="price"><{$products.list[i].price|number_format}>円</p>
    </a>
  </div>
<{/section}>
```

**出力されるHTML**（`$products.list` が2件のとき）

```html
<div class="item">
  <a href="/item/1001">
    <p class="name">コットンTシャツ</p>
    <p class="price">2,980円</p>
  </a>
</div>
<div class="item">
  <a href="/item/1002">
    <p class="name">リネンシャツ</p>
    <p class="price">5,400円</p>
  </a>
</div>
```

### foreach を使う場合

`<{foreach}>` は各要素を変数に受け取って回します。`from` に対象配列、`item` に要素を受け取る変数名を指定します。

**Smarty**

```html
<{foreach from=$news.list item=news}>
  <li>
    <span class="date"><{$news.date}></span>
    <a href="<{$news.url}>"><{$news.title}></a>
  </li>
<{/foreach}>
```

**出力されるHTML**（`$news.list` が2件のとき）

```html
<li>
  <span class="date">2026.06.01</span>
  <a href="/news/10">夏季休業のお知らせ</a>
</li>
<li>
  <span class="date">2026.05.20</span>
  <a href="/news/9">新商品入荷のお知らせ</a>
</li>
```
