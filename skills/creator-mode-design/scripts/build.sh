#!/usr/bin/env bash
# 使い方: bash build.sh <デザインセットのフォルダ>
set -eu

src_dir="${1:?デザインセットのフォルダを指定してください}"

work_dir="$(mktemp -d)"
encoding_check_file="$(mktemp)"
cdar_dir="$PWD/$(basename "$src_dir").cdar"

cd "$src_dir"
if [ ! -f config.json ]; then
  echo "config.json が見つかりません: $src_dir/config.json"
  exit 1
fi

if ! iconv -f UTF-8 -t UTF-8 config.json >"$encoding_check_file" 2>/dev/null; then
  echo "config.json は UTF-8 で保存してください: $src_dir/config.json"
  exit 1
fi

cp config.json "$work_dir/"
while IFS= read -r -d '' file; do
  mkdir -p "$work_dir/$(dirname "$file")"
  if ! iconv -f UTF-8 -t EUC-JP "$file" >"$work_dir/$file" 2>/dev/null; then
    if ! iconv -f EUC-JP -t UTF-8 "$file" >"$encoding_check_file" 2>/dev/null; then
      echo "EUC-JP に変換できない文字があります: ${file#./}"
      exit 1
    fi
    cp "$file" "$work_dir/$file"
  fi
done < <(find . -type f \( -name '*.html' -o -name '*.css' -o -name '*.js' \) -print0)

cd "$work_dir"
zip -qrD - . >"$cdar_dir"
echo "$cdar_dir を生成しました。"
