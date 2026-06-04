#!/usr/bin/env bash
set -euo pipefail

DST=~/.config/nvim/treesitter/parser
SRC=$(mktemp -d)
mkdir -p "$DST"

# Usage: build <repo-url> <output-lang> [<subdir-in-repo>]
build() {
	local url=$1 lang=$2 subdir=${3:-}
	local name
	name=$(basename "$url" .git)
	local repo="$SRC/$name"

	echo ">>> $lang  ($url)"
	rm -rf "$repo"
	git clone --depth=1 --quiet "$url" "$repo"

	if [ -n "$subdir" ]; then
		(cd "$repo/$subdir" && tree-sitter build)
		# Newer grammars output parser.so, older ones output <lang>.so
		if [ -f "$repo/$subdir/parser.so" ]; then
			src="$repo/$subdir/parser.so"
		elif [ -f "$repo/$subdir/$lang.so" ]; then
			src="$repo/$subdir/$lang.so"
		else
			echo "ERROR: no .so produced for $lang" >&2
			exit 1
		fi
		cp "$src" "$DST/$lang.so"
	else
		(cd "$repo" && tree-sitter build)
		if [ -f "$repo/parser.so" ]; then
			src="$repo/parser.so"
		elif [ -f "$repo/$lang.so" ]; then
			src="$repo/$lang.so"
		else
			echo "ERROR: no .so produced for $lang" >&2
			exit 1
		fi
		cp "$src" "$DST/$lang.so"
	fi

}
build https://github.com/tree-sitter/tree-sitter-typescript typescript typescript
build https://github.com/tree-sitter/tree-sitter-typescript tsx tsx

build https://github.com/tree-sitter/tree-sitter-html html
build https://github.com/tree-sitter/tree-sitter-css css
build https://github.com/tree-sitter/tree-sitter-json json

rm -rf "$SRC"
echo ">>> Done. Parsers in $DST:"
ls "$DST"
