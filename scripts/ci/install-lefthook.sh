#!/usr/bin/env bash
set -e

LEFTHOOK_VERSION="${LEFTHOOK_VERSION:-2.1.0}"

if command -v lefthook >/dev/null 2>&1; then
	echo "lefthook already installed: $(lefthook --version 2>/dev/null || true)"
	exit 0
fi

case "$(uname -s)" in
	Darwin)
		if command -v brew >/dev/null 2>&1; then
			echo "Installing lefthook via Homebrew..."
			brew install lefthook
		else
			echo "Error: Homebrew not found. Install from https://brew.sh"
			exit 1
		fi
		;;
	Linux)
		if command -v brew >/dev/null 2>&1; then
			echo "Installing lefthook via Homebrew..."
			brew install lefthook
		elif command -v snap >/dev/null 2>&1; then
			echo "Installing lefthook via snap..."
			sudo snap install lefthook --classic
		else
			echo "Installing lefthook from GitHub release..."
			arch=$(uname -m)
			case "$arch" in
				x86_64) suffix="Linux_x86_64" ;;
				aarch64|arm64) suffix="Linux_arm64" ;;
				*) echo "Unsupported arch: $arch"; exit 1 ;;
			esac
			url="https://github.com/evilmartians/lefthook/releases/download/v${LEFTHOOK_VERSION}/lefthook_${LEFTHOOK_VERSION}_${suffix}"
			bin_dir="${HOME}/.local/bin"
			mkdir -p "$bin_dir"
			curl -sSL "$url" -o "$bin_dir/lefthook" && chmod +x "$bin_dir/lefthook"
			echo "Installed to $bin_dir/lefthook (ensure $bin_dir is in PATH)"
		fi
		;;
	*)
		echo "Unsupported OS: $(uname -s)"
		exit 1
		;;
esac
