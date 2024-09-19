# 対話型で改修前後のAPIレスポンスのdiffを取るスクリプト

## 使い方

### 事前準備

検証したいエンドポイント一覧を記載したファイルを `.request.txt` などに用意する

↓こんな感じ
```
/v1/aaa
/v1/bbb/ccc
/v2/exmample?query=test
```

### 実行方法
```
$ bash compare-response.sh 

## 以下、対話型で聞かれた通り必要事項を入力していく
```

※ GETのみ対応
※ sh ではdiffコマンドの`<()`が解釈されずsyntax errorになるため**bash**で実行すること

### 実行結果
./result.txt に出力される