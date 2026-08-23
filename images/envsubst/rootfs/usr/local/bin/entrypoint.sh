#!/usr/bin/env sh
set -eu

DST_DIR="${DST_DIR:-/output}"

find -L . -name '..*' -prune -o -type f -print | while read -r file; do
  mkdir -p "$DST_DIR/$(dirname "$file")"
  envsubst < $file > "$DST_DIR/$file"
done
