#!/usr/bin/env sh
set -eu

DST_DIR="${DST_DIR:-/output}"

find . -type f | while read -r file; do
  mkdir -p "$DST_DIR/$(dirname "$file")"
  envsubst < $file > "$DST_DIR/$file"
done
