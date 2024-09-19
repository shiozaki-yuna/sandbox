#! /bin/bash

echo "＞ 基準となる環境と比較したい環境のhostを入力してください"
read -e "base_host" "target_host"

if [ -z $base_host ]; then
  echo "⚠️ 基準となる環境のhostが入力されていません"
  exit
fi

if [ -z $target_host ]; then
  echo "⚠️ 比較したい環境のhostが入力されていません"
  exit
fi

echo "＞ 検証したいエンドポイント一覧のファイルパスを入力してください"
read -e "target_paths"

if [ -z $target_paths ]; then
  echo "⚠️ 検証したいエントリポイント一覧のファイルパスが入力されていません"
  exit
fi

echo "＞ httpヘッダー情報を付与しますか？(y/n)"
read -e "is_header"

arg_headers=""
if [ $is_header != "y" ] && [ $is_header != "n" ]; then
  echo "⚠️ 引数が不正です"
  exit
fi

if [ $is_header == "y" ]; then
  echo "＞ 付与したいヘッダー情報を入力してください"
  read -e "arg_header"
  if [ -z $arg_header ]; then
    echo "⚠️ 付与したいヘッダー情報が入力されていません"
    exit
  fi
fi

for target_path in `cat ./$target_paths`; do
  base_api_url="http://"$base_host""$target_path""
  target_api_url="http://"$target_host""$target_path""

  if [ $is_header = "y" ]; then
    http_header='-H "'$arg_header'" '
  fi

  head="## 検証： $target_path"
  echo $head >> ./result.txt
  diff <(curl $http_header$base_api_url | jq) <(curl $http_headertarget_api_url | jq) >> ./result.txt
done