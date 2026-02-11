#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
staged=$(git -C "$REPO_ROOT" diff --cached --name-only --diff-filter=ACM | grep '^rules/' || true)

if [[ -z "$staged" ]]; then
	exit 0
fi

echo "$staged" | xargs "$SCRIPT_DIR/../sort-payload.sh"
echo "$staged" | while read -r path; do
	[[ -n "$path" ]] && git -C "$REPO_ROOT" add "$path"
done
echo "Lint (sort payload): updated and re-staged rules."
