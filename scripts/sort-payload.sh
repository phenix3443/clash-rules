#!/usr/bin/env bash
set -e

for f in "$@"; do
	[[ -f "$f" ]] || continue
	if ! grep -q '^payload:' "$f"; then
		continue
	fi
	head -1 "$f" > "$f.tmp"
	grep '^  - ' "$f" | sort >> "$f.tmp"
	mv "$f.tmp" "$f"
done
