#!/usr/bin/env bash
set -euo pipefail

docs_dir="/home/nova/hello-agents/docs"

# 按长度从长到短列出，避免 “第十” 先被替换
declare -a patterns=(
  "第十六章:16"
  "第十五章:15"
  "第十四章:14"
  "第十三章:13"
  "第十二章:12"
  "第十一章:11"
  "第十章:10"
  "第九章:9"
  "第八章:8"
  "第七章:7"
  "第六章:6"
  "第五章:5"
  "第四章:4"
  "第三章:3"
  "第二章:2"
  "第一章:1"
)

shopt -s nullglob
for f in "$docs_dir"/*.md; do
  fname="$(basename "$f")"
  newname="$fname"
  for kv in "${patterns[@]}"; do
    pat="${kv%%:*}"
    rep="${kv#*:}"
    newname="${newname//$pat/$rep}"
  done
  if [[ "$newname" != "$fname" ]]; then
    mv -v -- "$docs_dir/$fname" "$docs_dir/$newname"
  fi
done
shopt -u nullglob