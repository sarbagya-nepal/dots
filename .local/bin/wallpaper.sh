#!/usr/bin/env bash
set -euo pipefail

WALL="${1:-}"

if [[ -z "$WALL" ]]; then
    echo "usage: ${0##*/} <wallpaper>"
    exit 1
fi

if [[ ! -f "$WALL" ]]; then
    echo "error: file not found: $WALL"
    exit 1
fi

SCHEME="scheme-tonal-spot"

# -------------------------
# DETECT MODE (fastest - python median)
# -------------------------

tmpfile=$(mktemp)
trap 'rm -f "$tmpfile"' EXIT

magick "$WALL" \
    -colorspace Gray \
    -resize 30x30^ \
    -depth 8 \
    "$tmpfile.gray" 2>/dev/null

median=$(python3 -c "
import sys
data = open('$tmpfile.gray', 'rb').read()
vals = list(data)
vals.sort()
m = vals[len(vals)//2] / 255
print(f'{m:.4f}')
")

echo "median: $median"

if (( $(echo "$median < 0.4" | bc -l) )); then
    MODE="dark"
else
    MODE="light"
fi

echo "mode: $MODE"

matugen image "$WALL" --source-color-index 0 -m "$MODE" -t "$SCHEME" --contrast 0.1
