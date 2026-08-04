## config.json

config.jsonは以下のフォーマットに従って定義します

```json
{
  // バージョンを指定する
  "version": 1, 
  // 原則レスポンシブデザインにするのでtrue
  "responsive": true,
  "module": [
    // _module_/xxx.htmlに定義したモジュールを指定する
    {
      // 拡張子.htmlは除いたファイル名を指定する
      // 例：_module_/header.htmlであれば、headerを指定する
      "name": "xxx",
      // モジュールの説明
      // 例：_module_/header.htmlであれば、ヘッダーを指定する
      "description": "xxx"
    },
  ],
  "freepage": [
    // standard/freepage/xxx.htmlに定義したページを指定。
    {
      // ページIDを指定。ファイル名と一致させる必要はない。/view/page/ページIDがURLとなる
      // 例：standard/freepage/blog.htmlであれば、blogを指定する
      "page_id": "blog",
      // ページ名を指定
      // 例：standard/freepage/blog.htmlであれば、ブログを指定する
      "name": "ブログ",
      // 公開するのであればtrue、非公開にするのであればfalseを指定する
      "public": true
    }
  ]
}
```
