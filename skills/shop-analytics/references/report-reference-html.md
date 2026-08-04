# HTML出力

Chart.jsによるインタラクティブなグラフを埋め込んだHTMLファイル。売上推移、ダッシュボード、詳細分析、前期間比較の可視化に使う。スマホ・タブレット・PCで崩れないレスポンシブレイアウトを前提とする。

## 生成方法

TailwindCSS（CDN）と Chart.js（CDN）を使ったHTMLファイルを生成し、`open` コマンドでブラウザに表示する。

### 必須CDN

```html
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
```

### HTML雛形

```html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>レポートタイトル</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-[#F8F8FB] text-[#1A1A1A]">
  <main class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-4 sm:py-6">
    <!-- ヘッダー -->
    <header class="mb-4 sm:mb-6">
      <h1 class="text-xl sm:text-2xl lg:text-3xl font-bold">レポートタイトル</h1>
      <p class="mt-1 text-xs sm:text-sm text-[#626264]">対象期間: 2026-01-01 〜 2026-03-31</p>
    </header>

    <!-- 上段: KPIカード -->
    <section class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4 mb-6">
      ...
    </section>

    <!-- 中段: 時系列グラフ -->
    <section class="grid grid-cols-1 lg:grid-cols-2 gap-4 mb-6">
      ...
    </section>

    <!-- 下段: 内訳グラフ -->
    <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      ...
    </section>
  </main>
</body>
</html>
```

ビューポートメタタグ (`<meta name="viewport" content="width=device-width, initial-scale=1.0">`) は必ず入れる。これがないとスマホで縮小表示されレスポンシブが効かない。

## レスポンシブ設計の原則

参考: [Tailwind CSS - Responsive Design](https://tailwindcss.com/docs/responsive-design)

### ブレークポイント

| プレフィックス | 最小幅 | 想定デバイス |
|---|---|---|
| (なし) | 0px〜 | スマホ（モバイルファーストの基準） |
| `sm:` | 640px〜 | 大きめスマホ・小型タブレット |
| `md:` | 768px〜 | タブレット |
| `lg:` | 1024px〜 | 小型PC・横向きタブレット |
| `xl:` | 1280px〜 | PC |
| `2xl:` | 1536px〜 | 大型ディスプレイ |

### モバイルファースト原則（最重要）

**プレフィックスのない utility は全画面サイズに適用される**。プレフィックス付き（`md:` など）は **そのブレークポイント以上** で適用される。「`sm:` = 小さい画面向け」ではなく、「`sm:` = sm ブレークポイント（640px）以上」という意味。

```html
<!-- ✗ NG: 640px以上でしか中央寄せにならず、スマホでは左寄せになる -->
<div class="sm:text-center">...</div>

<!-- ✓ OK: スマホで中央寄せ、640px以上で左寄せ -->
<div class="text-center sm:text-left">...</div>
```

つまり書き方は **「スマホ向けのレイアウトをノープレフィックスで書き、大きい画面で変えたい部分だけプレフィックス付きで上書き」** が基本。

```html
<!-- スマホ: w-16, タブレット: w-32, PC: w-48 -->
<img class="w-16 md:w-32 lg:w-48" src="..." />

<!-- スマホ: 1カラム, sm以上: 2カラム, lg以上: 4カラム -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">...</div>
```

### 範囲指定（特定の画面サイズだけに適用）

`max-*` バリアントを組み合わせて範囲を限定できる。

```html
<!-- mdからlg未満まで（768px〜1023px）にだけ適用 -->
<div class="md:max-lg:flex">...</div>

<!-- スマホ（sm未満、640px未満）にだけ適用 -->
<div class="max-sm:hidden">...</div>
```

任意のpx値もプレフィックスとして使える（必要なときだけ）。

```html
<div class="min-[320px]:text-center max-[600px]:bg-sky-300">...</div>
```

### 固定幅は使わない

固定px幅（`w-[1200px]` など）でレイアウトを組まない。常に `grid grid-cols-N` または `flex flex-wrap` を使い、コンテナ幅に応じて自動で折り返すように書く。

## レイアウト原則

視線は左上から右下へ流れる。この動きに沿って、全体から部分へ情報を配置する。スマホでは縦に積み上げ、PCでは横並びに展開する。

| 配置 | 内容 | 推奨Tailwindクラス |
|---|---|---|
| 上段 | KPIカード（売上金額・受注件数・客単価・前期間比など主要指標） | `grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4` |
| 中段 | 時系列グラフ（売上推移・受注推移など傾向を示すグラフ） | `grid grid-cols-1 lg:grid-cols-2 gap-4` |
| 下段 | 内訳グラフ（商品別・カテゴリ別・地域別など詳細の分解） | `grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4` |

左上が最も目を引く位置なので、最重要の指標を大きく配置する。情報量が多い場合はセクションを分割する。

## KPIカード

判断や行動を左右する主要指標を、数値テキストで大きく表示するコンポーネント。

```html
<div class="rounded-lg bg-[#E8F1FE] p-4 sm:p-5 lg:p-6">
  <div class="text-xs sm:text-sm text-[#626264]">売上金額</div>
  <div class="mt-1 text-2xl sm:text-3xl lg:text-4xl font-bold text-[#1A1A1A] tabular-nums">
    ¥1,234,567
  </div>
  <div class="mt-2 text-xs sm:text-sm text-[#0031D8]">
    ↑ 12.3%（前期間比）
  </div>
</div>
```

| 要素 | ルール |
|---|---|
| 数値 | レスポンシブにフォントサイズ調整（`text-2xl sm:text-3xl lg:text-4xl`）、`tabular-nums` で桁揃え |
| ラベル | 指標名を数値の上に小さく表示（`text-xs sm:text-sm`） |
| 前期間比 | 増加は青（`#0031D8`）、減少は赤（`#FA0000`）で矢印と割合を併記する |
| 背景 | 増加は `#E8F1FE`、減少は `#FDEEEE` で色分けする |
| パディング | `p-4 sm:p-5 lg:p-6` で画面サイズに応じて調整 |

## グラフ（Chart.js）

### 必須設定

レスポンシブにするには、グラフを **固定高さのコンテナ** で包み、Chart.js 側で `maintainAspectRatio: false` を指定する。これがないとスマホでcanvasが正方形に縮んだり画面外にはみ出したりする。

```html
<div class="rounded-lg bg-white border border-[#D8D8DB] p-3 sm:p-4">
  <h3 class="text-sm sm:text-base font-semibold mb-3">月別売上推移</h3>
  <div class="relative h-56 sm:h-64 lg:h-72">
    <canvas id="salesChart"></canvas>
  </div>
</div>

<script>
  new Chart(document.getElementById('salesChart'), {
    type: 'line',
    data: {
      labels: ['1月', '2月', '3月'],
      datasets: [{
        label: '売上',
        data: [1200000, 1450000, 1800000],
        borderColor: '#264AF4',
        backgroundColor: 'rgba(38, 74, 244, 0.1)',
        fill: true
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { position: 'bottom' }
      },
      scales: {
        y: { beginAtZero: true }
      }
    }
  });
</script>
```

### スマホでの可読性対策

| 観点 | 対策 |
|---|---|
| 軸ラベルが長い | `ticks: { maxRotation: 45, autoSkip: true }` で斜めにする・間引く |
| 凡例が画面外にはみ出す | `legend: { position: 'bottom' }` を基本にする |
| 系列数が多い | スマホでは上位5件のみ表示、それ以下を「その他」に集約 |
| データラベルが重なる | 密度に応じて間引く、もしくはスマホでは非表示 |
| データ点数が多くて潰れる | `<div class="overflow-x-auto">` でラップし、canvasに `min-w-[640px]` を付ける |
| 円グラフのラベルがはみ出す | スマホでは凡例だけにして、グラフ内ラベルは省略 |

横スクロールを使うパターンの例:

```html
<div class="overflow-x-auto">
  <div class="relative h-64 min-w-[640px]">
    <canvas id="dailySalesChart"></canvas>
  </div>
</div>
```

## カラーパレット

| 用途 | 色 | コード |
|---|---|---|
| メイン系列 | Blue 700 | `#264AF4` |
| サブ系列 | Blue 300 | `#4979F5` |
| ポジティブ（増加） | Blue | `#0031D8` |
| ネガティブ（減少） | Red | `#FA0000` |
| ポジティブ背景 | Light Blue | `#E8F1FE` |
| ネガティブ背景 | Light Red | `#FDEEEE` |
| 本文テキスト | Dark | `#1A1A1A` |
| 補足テキスト | Gray | `#626264` |
| 背景 | Light Gray | `#F8F8FB` |
| 罫線 | Border | `#D8D8DB` |

Tailwindの任意値構文（`bg-[#264AF4]`、`text-[#1A1A1A]` など）でこれらの色を直接使う。

グラフで使用する色が1〜3色の場合は濃い明度を使い、4〜5色の場合は明度を広く使って区別する。色だけで分類を識別させず、ラベルやパターンを併用する。

## テーブル

レポートに含める表は、スマホで横スクロールできるようにする。

```html
<div class="overflow-x-auto rounded-lg border border-[#D8D8DB] bg-white">
  <table class="min-w-full text-xs sm:text-sm">
    <thead class="bg-[#F8F8FB] text-[#626264]">
      <tr>
        <th class="px-3 py-2 text-left">商品</th>
        <th class="px-3 py-2 text-right">売上</th>
        <th class="px-3 py-2 text-right">前期間比</th>
      </tr>
    </thead>
    <tbody class="divide-y divide-[#D8D8DB]">
      <tr>
        <td class="px-3 py-2 whitespace-nowrap">商品A</td>
        <td class="px-3 py-2 text-right tabular-nums">¥123,456</td>
        <td class="px-3 py-2 text-right text-[#0031D8]">↑ 12.3%</td>
      </tr>
    </tbody>
  </table>
</div>
```

## グラフ設計ルール

### Do

- 全体の指標を先に表示し、その下に詳細グラフを配置する
- 棒グラフ・円グラフの項目は数量の大小順など意味のある順序で並べる
- 不要な要素（グリッド線・装飾・3D表現）は削除する
- グラフに使用する色数を絞り、注目すべき系列を明確にする
- タイトルにグラフの内容とデータ種別を表記する（例:「月別売上推移」）
- タイトルや凡例をシンプルに保つ
- 凡例はグラフに隣接させ、凡例の順序をグラフの系列順と一致させる
- 棒グラフの原点は0にする
- 比較対象（前期間・目標値）を併記する
- グラフコンテナに固定高さ（`h-56 sm:h-64 lg:h-72`）を指定し、`maintainAspectRatio: false` でレスポンシブ表示
- スマホでは凡例を下（`legend.position: 'bottom'`）に、軸ラベルは短縮するか斜めにする
- ビューポートメタタグを必ず指定する
- 表は `overflow-x-auto` でラップし、横スクロール可能にする

### Don't

- 詳細グラフだけを並べて全体像が見えない構成にしない
- 項目を意味のない順序（あいうえお順など）で並べない
- 目盛線やタイトルを過剰に記載しない
- 3D表現やドロップシャドウなど装飾的な表現を使わない
- 色数を増やして注目ポイントが不明瞭になる構成にしない
- グラフの原点を0以外にして差を誇張しない
- 固定px幅・高さでレイアウトを組まない（`w-[1200px]` のような書き方を避ける）
- 横並びのみを前提にしない（スマホでは1カラムに崩れる前提で設計する）
- canvas に直接 `width`/`height` 属性を指定しない（`maintainAspectRatio: false` と高さ指定コンテナで代替）
- `sm:` を「スマホ向け」と勘違いしない（実際は640px以上に適用されるため、スマホには反映されない）
- スマホ向けスタイルにプレフィックスを付けない（`sm:text-center` ではなく `text-center sm:text-left` のように、デフォルトをスマホ前提で書く）
