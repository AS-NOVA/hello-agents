#!/usr/bin/env bash
set -euo pipefail

base_dir="/home/nova/hello-agents"
docs_dir="$base_dir/docs"

for i in $(seq 1 16); do
  dir="$docs_dir/chapter$i"
  if [[ ! -d "$dir" ]]; then
    echo "跳过不存在的目录：$dir"
    continue
  fi

  # 删除英文文件（文件名以 Chapter{i} 开头）
  find "$dir" -maxdepth 1 -type f -name "Chapter${i}*.md" -print -delete

  # 将剩余的 .md（视为中文）移动到 docs 根目录
  shopt -s nullglob
  md_files=("$dir"/*.md)
  shopt -u nullglob
  for f in "${md_files[@]}"; do
    mv -v "$f" "$docs_dir/"
  done

  # 删除空目录
  if rmdir "$dir" 2>/dev/null; then
    echo "已删除目录：$dir"
  else
    echo "目录非空，未删除：$dir"
  fi
done