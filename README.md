# エージェントスキル

GMOメイクショップが開発・公開するエージェントスキルです。

## スキル一覧

| スキル | 名称 | 説明 |
|---|---|---|
| [`shop-analytics`](skills/shop-analytics) | ショップ分析スキル | 注文・会員データをもとに、売上状況の把握、原因分析、次に実施すべき施策の提案を行うスキルです。 |
| [`optimize-products`](skills/optimize-products) | 商品分析・改善スキル | 注文データと商品設定をもとに、商品の売れ行きに関する課題を分析し、改善施策の提案から商品設定の変更まで行うスキルです。 |
| [`creator-mode-design`](skills/creator-mode-design) | クリエイターモードデザインスキル | コーディングの知識がなくても、クリエイターモードを使用したショップデザインを行えるスキルです。 |
| [`shop-opening`](skills/shop-opening) | ショップ開店スキル | makeshop byGMOでネットショップを新規開店・公開するために必要な準備を支援するスキルです。 |

## インストール

[GitHub CLI](https://cli.github.com/) でインストールできます。

```bash
gh skill install gmomakeshop/agent-skills
```

スキルを指定してインストールすることもできます。

```bash
gh skill install gmomakeshop/agent-skills shop-analytics
```

## コントリビュート

[CONTRIBUTING.md](CONTRIBUTING.md) をご覧ください。Pull Request は受け付けていません。

## セキュリティ

脆弱性の報告方法は [SECURITY.md](SECURITY.md) をご覧ください。

## ライセンス

[MIT License](LICENSE)
