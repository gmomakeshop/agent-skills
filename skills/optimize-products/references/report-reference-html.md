# HTML出力

Chart.jsのグラフを埋め込んだHTMLファイル。商品診断レポート（サマリー・調査結果・改善案）の可視化に使う。スマホ・タブレット・PCで崩れないレスポンシブレイアウトを前提とする。

読み手は分析やECの専門家ではない店主。CVR・LTV・SKU・価格弾力性のような専門用語はそのまま使わず、「見た人のうち買ってくれた割合」「一人のお客さんが使ってくれる合計金額」のように言い換える（カッコ書きでの併記は可）。判定・根拠・改善案のどれも、専門知識なしで納得できる言葉になっているかを、レイアウトと同じ重みで確認する。

## レポート構成

「結論 → 根拠 → 打ち手」の順で3セクションに組み立てる。ヘッダーに対象商品・対象期間・データ取得時点を必ず記載する。

| 順序 | セクション | 内容 | 主な表現 | レイアウト |
|---|---|---|---|---|
| 1 | サマリー | 問題の所在の一文 + 決め手になった数値 | KPIカード | `grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4` |
| 2 | 調査結果 | 18の調査観点の判定と根拠 | 判定バッジ + グラフ・ミニ表 | `grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4` |
| 3 | 改善案 | 変更サマリー・現在の設定・変更案・効果見込み | 改善案カード | 優先度順に縦積み |

### 1. サマリー

問題の所在（流入がないのか・流入はあるが買われないのか・利益が出ないのか）を一文で明示し、根拠となる数値をKPIカードで大きく表示する。表示する数値は固定ではなく、調査で判断の決め手になったものを選ぶ。数値単体では判断できないため、前期間比・ショップ平均・目標値などの比較対象を必ず併記する。

### 2. 調査結果

18の調査観点を、問題の有無にかかわらず観点ごとに掲載する。各観点に判定バッジを添え、色だけで識別させずテキストを併記する。

- **問題あり**は先頭に置き、大きめのグラフ（`md:col-span-2`など）で根拠を示す
- **問題なし**もコンパクトな数値・ミニ表で「何を見て判断したか」が分かるようにする。確認済みであること自体に価値があるため省略しない
- **対象外**は理由を一行で書く
- 根拠は文章で説明せずグラフ・表・数値カードで可視化し、文章は読み取れたことの一行サマリーに留める

```html
<span class="rounded px-2 py-0.5 text-xs font-semibold bg-[#FDEEEE] text-[#FA0000]">問題あり</span>
<span class="rounded px-2 py-0.5 text-xs font-semibold bg-[#E8F1FE] text-[#0031D8]">問題なし</span>
<span class="rounded px-2 py-0.5 text-xs font-semibold bg-[#F8F8FB] text-[#626264] border border-[#D8D8DB]">対象外</span>
```

### 3. 改善案

1改善案 = 1枚の改善案カード。文章でつらつら説明せず、4要素で構成する。

| 要素 | 内容 |
|---|---|
| ① 変更サマリー | 何をどう変えるかの一文 + 優先度バッジ + 根拠となる調査観点と数値 |
| ② 現在の設定 | 変更対象の設定項目名と現在の値そのもの |
| ③ 変更案の設定 | 変更後の値そのもの（新しい商品名の案文・説明文の案文・価格やポイントの数値） |
| ④ 効果見込み | 現状と改善後見込みの比較 + 算出根拠の一行 |

- ②③は値そのものを併記する。「変更したほうがよい」で終わる提案は書かない。ユーザーが提案された値を見て自分で判断し、合意できる粒度にするため
- 優先度は「高」「中」「低」と表記する。独自の略記・記号は使わない
- カードは優先度順に並べる
- 設定変更で届かない+αの施策（セット販売・キャンペーン・撮影の改善など）も同じカード形式で示す。②③の代わりに「何をいつどう実行するか」を書く
- 根拠になるデータがなく効果を数値化できない改善案は、数値をでっち上げず方向性バッジで示す

## 生成方法

TailwindCSS（CDN）と Chart.js（CDN）を使ったHTMLファイルを生成し、ブラウザで開いて表示する。

```html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>商品診断レポート</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-[#F8F8FB] text-[#1A1A1A]">
  <main class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-4 sm:py-6">
    <header class="mb-4 sm:mb-6">
      <h1 class="text-xl sm:text-2xl lg:text-3xl font-bold">商品診断レポート: 〇〇</h1>
      <p class="mt-1 text-xs sm:text-sm text-[#626264]">対象期間: YYYY-MM-DD 〜 YYYY-MM-DD ／ データ取得: YYYY-MM-DD</p>
    </header>

    <section class="mb-6">
      <h2 class="text-lg sm:text-xl font-bold mb-3">サマリー</h2>
      <p class="text-sm sm:text-base mb-3">...</p>
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4">...</div>
    </section>

    <section class="mb-6">
      <h2 class="text-lg sm:text-xl font-bold mb-3">調査結果</h2>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">...</div>
    </section>

    <section>
      <h2 class="text-lg sm:text-xl font-bold mb-3">改善案</h2>
      ...
    </section>
  </main>
</body>
</html>
```

ビューポートメタタグは必ず入れる。これがないとスマホで縮小表示されレスポンシブが効かない。

## レイアウトの原則

- **モバイルファースト**：プレフィックスなしでスマホ向けを書き、大きい画面で変えたい部分だけ`sm:`／`md:`／`lg:`で上書きする。`sm:`は「小さい画面向け」ではなく「640px以上」を意味する
- **固定幅を使わない**：`w-[1200px]`のような固定px幅でレイアウトを組まない。常に`grid grid-cols-N`または`flex flex-wrap`で自動折り返しにする
- 参考: [Tailwind CSS - Responsive Design](https://tailwindcss.com/docs/responsive-design)

## 可視化ファースト原則

調査結果は言葉で説明せず、図・グラフ・表・数値カードで示す。文章は「グラフから何を読み取るべきか」の一行サマリーと判定の根拠に留め、3行を超える説明段落を書きたくなったら、その内容をグラフ・表・図解に変換できないかを先に考える。

| 伝えたい内容 | 適した表現 |
|---|---|
| 推移・トレンド | 折れ線グラフ |
| 構成比・内訳 | 円グラフ・ドーナツグラフ・横棒グラフ |
| 項目間の比較 | 棒グラフ |
| 単一の重要数値と前期間比 | KPIカード |
| 複数項目の正確な値の参照 | テーブル |
| 判定・状態 | バッジ（テキスト併記） |
| 設定の変更前後 | Before/After 2カラム比較 |
| 改善案の効果見込み | Before/Afterの数字、または比較グラフ |

## KPIカード

```html
<div class="rounded-lg bg-[#E8F1FE] p-4 sm:p-5 lg:p-6">
  <div class="text-xs sm:text-sm text-[#626264]">売上金額</div>
  <div class="mt-1 text-2xl sm:text-3xl lg:text-4xl font-bold text-[#1A1A1A] tabular-nums">¥1,234,567</div>
  <div class="mt-2 text-xs sm:text-sm text-[#0031D8]">↑ 12.3%（前期間比）</div>
</div>
```

| 要素 | ルール |
|---|---|
| 数値 | `text-2xl sm:text-3xl lg:text-4xl`、`tabular-nums`で桁揃え |
| ラベル | 指標名を数値の上に小さく（`text-xs sm:text-sm`） |
| 前期間比 | 増加は青（`#0031D8`）、減少は赤（`#FA0000`）で矢印と割合を併記 |
| 背景 | 増加は`#E8F1FE`、減少は`#FDEEEE` |

## 改善案カード

```html
<article class="rounded-lg bg-white border border-[#D8D8DB] p-4 sm:p-5 mb-4">
  <!-- ① 変更サマリー -->
  <header class="flex flex-wrap items-center gap-2 mb-1">
    <span class="rounded px-2 py-0.5 text-xs font-semibold bg-[#FDEEEE] text-[#FA0000]">優先度: 高</span>
    <h3 class="text-base sm:text-lg font-bold">商品名にギフト訴求を追加する</h3>
  </header>
  <p class="text-xs sm:text-sm text-[#626264] mb-4">
    根拠: ギフト購入の割合 — 注文者≠送付先の注文が42%を占めるのに、商品名にギフト向けの記載がない
  </p>

  <!-- ② 現在の設定 / ③ 変更案 -->
  <div class="grid grid-cols-1 lg:grid-cols-2 gap-3 mb-4">
    <div class="rounded-lg bg-[#F8F8FB] border border-[#D8D8DB] p-3 sm:p-4">
      <div class="text-xs font-semibold text-[#626264] mb-2">現在の設定</div>
      <div class="text-xs text-[#626264]">商品名</div>
      <p class="text-sm">ドリップコーヒー 詰め合わせ 10袋</p>
    </div>
    <div class="rounded-lg bg-[#E8F1FE] border border-[#264AF4] p-3 sm:p-4">
      <div class="text-xs font-semibold text-[#0031D8] mb-2">変更案</div>
      <div class="text-xs text-[#626264]">商品名</div>
      <p class="text-sm">ドリップコーヒー 詰め合わせ 10袋 <strong class="text-[#0031D8]">ギフト包装無料 内祝いに</strong></p>
    </div>
  </div>

  <!-- ④ 効果見込み -->
  <div class="rounded-lg border border-[#D8D8DB] p-3 sm:p-4">
    <h4 class="text-sm font-semibold mb-1">効果見込み: 月間販売数</h4>
    <p class="text-xs text-[#626264] mb-2">算出根拠: ギフト訴求済みの類似商品との販売数差分から推定</p>
    <div class="relative h-48 sm:h-56"><canvas id="effectGiftName"></canvas></div>
  </div>
</article>
```

| 要素 | ルール |
|---|---|
| 優先度バッジ | 高 = `bg-[#FDEEEE] text-[#FA0000]`、中 = `bg-[#E8F1FE] text-[#0031D8]`、低 = `bg-[#F8F8FB] text-[#626264] border border-[#D8D8DB]` |
| 根拠 | どの調査観点のどの数値から導いたかを一行で書く |
| 現在の設定 | グレー背景（`bg-[#F8F8FB]`）。項目名を小さく添え、現在の値をそのまま載せる |
| 変更案 | 青背景（`bg-[#E8F1FE] border-[#264AF4]`）。変更・追加箇所は`<strong class="text-[#0031D8]">`で強調 |
| 複数項目の変更 | 1カード内で項目ごとに「現在/変更案」のペアを縦に並べる。別の問題への対処なら別カードに分ける |
| 説明文など長い値 | 全文を載せると比較できない場合は変更箇所の前後だけ抜粋し「…」で略す |
| 価格・数値の変更 | Before/Afterに加えて、値引き率・差額を変更案側に併記する |

### 効果見込みの見せ方

現状との比較で見せる。グラフは必須ではない。基準は素人目で一瞬で伝わるかどうかで、数字1つの変化ならBefore/Afterの数字を大きく並べるほうが速く伝わる。どの見せ方でも、見込み側には「（推定）」を付けて実績と区別し、算出根拠（類似商品の実績との差分、過去の値引き・ポイント施策への反応、ショップ平均との開きなど）を直前に一行で明記する。

**型1: Before/Afterの数字** — 1つの数値の変化を伝える基本形。

```html
<div class="flex flex-wrap items-center gap-3 sm:gap-4">
  <div>
    <div class="text-xs text-[#626264]">現状</div>
    <div class="text-2xl sm:text-3xl font-bold tabular-nums">24<span class="text-sm font-normal"> 個/月</span></div>
  </div>
  <div class="text-xl text-[#626264]">→</div>
  <div class="rounded-lg bg-[#E8F1FE] px-3 py-2">
    <div class="text-xs text-[#0031D8]">改善後見込み（推定）</div>
    <div class="text-2xl sm:text-3xl font-bold text-[#0031D8] tabular-nums">34<span class="text-sm font-normal"> 個/月</span></div>
  </div>
</div>
```

**型2: 単一指標の比較グラフ** — 他の系列や規模感と合わせて見せたい場合。現状と改善後見込みの2本棒。

```html
<script>
  new Chart(document.getElementById('effectGiftName'), {
    type: 'bar',
    data: {
      labels: ['現状', '改善後見込み（推定）'],
      datasets: [{
        data: [24, 34],
        backgroundColor: ['#264AF4', 'rgba(38, 74, 244, 0.35)'],
        borderColor: '#264AF4',
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: { legend: { display: false } },
      scales: { y: { beginAtZero: true, title: { display: true, text: '販売数（個/月）' } } }
    }
  });
</script>
```

**型3: 構成の変化** — 顧客層・バリエーション構成などの内訳が変わる場合。属性別の2系列グループ棒グラフ（`datasets`に「現状」「改善後見込み（推定）」の2系列）。

**型4: 推移への効果** — 下降トレンドの反転など時間軸で見せたい場合。実績の折れ線に、改善後見込みを破線（`borderDash: [6, 4]`）で接続する。

グラフを使う場合、見込み側の系列は薄い色（`rgba(38, 74, 244, 0.35)` + 実線ボーダー）にし、ラベルに「（推定）」を付ける。

**数値化できない場合** — 方向性バッジで示す。

```html
<span class="rounded px-2 py-0.5 text-xs font-semibold bg-[#E8F1FE] text-[#0031D8]">見込み: 売上増</span>
```

## グラフ（Chart.js）

レスポンシブにするには、グラフを**固定高さのコンテナ**で包み、Chart.js側で`maintainAspectRatio: false`を指定する。これがないとスマホでcanvasが正方形に縮んだり画面外にはみ出したりする。

```html
<div class="rounded-lg bg-white border border-[#D8D8DB] p-3 sm:p-4">
  <h3 class="text-sm sm:text-base font-semibold mb-3">月別売上推移</h3>
  <div class="relative h-56 sm:h-64 lg:h-72"><canvas id="salesChart"></canvas></div>
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
      plugins: { legend: { position: 'bottom' } },
      scales: { y: { beginAtZero: true } }
    }
  });
</script>
```

### スマホでの可読性対策

| 観点 | 対策 |
|---|---|
| 軸ラベルが長い | `ticks: { maxRotation: 45, autoSkip: true }` |
| 凡例が画面外にはみ出す | `legend: { position: 'bottom' }` を基本にする |
| 系列数が多い | スマホでは上位5件のみ表示し、それ以下を「その他」に集約 |
| データラベルが重なる | 密度に応じて間引く、もしくはスマホでは非表示 |
| データ点数が多くて潰れる | `<div class="overflow-x-auto">`でラップし、canvasに`min-w-[640px]`を付ける |
| 円グラフのラベルがはみ出す | スマホでは凡例だけにする |

## カラーパレット

| 用途 | コード |
|---|---|
| メイン系列 | `#264AF4` |
| サブ系列 | `#4979F5` |
| 見込み・推定系列 | `rgba(38, 74, 244, 0.35)` |
| ポジティブ（増加） | `#0031D8` |
| ネガティブ（減少） | `#FA0000` |
| ポジティブ背景 | `#E8F1FE` |
| ネガティブ背景 | `#FDEEEE` |
| 本文テキスト | `#1A1A1A` |
| 補足テキスト | `#626264` |
| 背景 | `#F8F8FB` |
| 罫線 | `#D8D8DB` |

Tailwindの任意値構文（`bg-[#264AF4]`など）で直接使う。グラフの色が1〜3色の場合は濃い明度を使い、4〜5色の場合は明度を広く使って区別する。色だけで分類を識別させず、ラベルやパターンを併用する。

## テーブル

スマホで横スクロールできるようにする。

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

**Do**

- 全体の指標を先に表示し、その下に詳細グラフを配置する
- 棒グラフ・円グラフの項目は数量の大小順など意味のある順序で並べる
- 不要な要素（グリッド線・装飾・3D表現）は削除する
- 色数を絞り、注目すべき系列を明確にする
- タイトルにグラフの内容とデータ種別を表記する
- 凡例はグラフに隣接させ、順序をグラフの系列順と一致させる
- 棒グラフの原点は0にする
- 比較対象（前期間・目標値・改善後見込み）を併記する
- 見込み・推定の系列は薄い色 + 「（推定）」ラベルで実績と区別する

**Don't**

- 詳細グラフだけを並べて全体像が見えない構成にしない
- 項目を意味のない順序で並べない
- 目盛線やタイトルを過剰に記載しない
- 3D表現やドロップシャドウなど装飾的な表現を使わない
- 色数を増やして注目ポイントを不明瞭にしない
- グラフの原点を0以外にして差を誇張しない
- 見込み・推定の数値を実績と同じ見た目で描かない
- canvasに直接`width`/`height`属性を指定しない
