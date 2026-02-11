#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
RULES_DIR="$REPO_ROOT/rules"
failed=0

if [[ ! -d "$RULES_DIR" ]]; then
	echo "rules dir not found: $RULES_DIR"
	exit 1
fi

shopt -s nullglob
rule_files=("$RULES_DIR"/*.yaml)
if [[ ${#rule_files[@]} -eq 0 ]]; then
	exit 0
fi

echo "Checking duplicate rules in rules/*.yaml ..."

for f in "${rule_files[@]}"; do
	rules=$(grep '^  - ' "$f" 2>/dev/null || true)
	if [[ -z "$rules" ]]; then
		continue
	fi
	dups=$(echo "$rules" | sort | uniq -d)
	if [[ -n "$dups" ]]; then
		echo "Duplicate rule(s) in $(basename "$f"):"
		echo "$dups" | sed 's/^/  /'
		failed=1
	fi
done

declare -A rule_to_files
while IFS= read -r line; do
	path="${line%%:*}"
	rest="${line#*:}"
	rule="${rest# }"
	file=$(basename "$path")
	if [[ -z "${rule_to_files[$rule]}" ]]; then
		rule_to_files[$rule]="$file"
	else
		rule_to_files[$rule]="${rule_to_files[$rule]}, $file"
	fi
done < <(grep -h '^  - ' "${rule_files[@]}" 2>/dev/null || true)

for rule in "${!rule_to_files[@]}"; do
	files="${rule_to_files[$rule]}"
	count=$(echo "$files" | awk -F', ' '{print NF}')
	if [[ "$count" -gt 1 ]]; then
		echo "Rule in multiple files: $rule"
		echo "  files: $files"
		failed=1
	fi
done

if [[ $failed -eq 1 ]]; then
	echo "Fix duplicate rules above and try again."
	exit 1
fi

echo "No duplicate rules found."
