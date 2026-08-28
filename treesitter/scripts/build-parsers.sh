#!/usr/bin/env bash
set -euo pipefail

for tool in git jq tree-sitter; do
	if ! command -v "$tool" >/dev/null 2>&1; then
		echo "ERROR: required command not found: $tool" >&2
		exit 1
	fi
done

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
CONFIG_DIR=$(cd -- "$SCRIPT_DIR/../.." && pwd)
PARSER_DST="$CONFIG_DIR/treesitter/parser"
QUERY_DST="$CONFIG_DIR/treesitter/queries"
SRC=$(mktemp -d)
trap 'rm -rf "$SRC"' EXIT

mkdir -p "$PARSER_DST" "$QUERY_DST"

NVIM_TREESITTER="$SRC/nvim-treesitter"
echo ">>> Fetching the nvim-treesitter parser lockfile and queries"
git clone --branch=master --depth=1 --quiet https://github.com/nvim-treesitter/nvim-treesitter "$NVIM_TREESITTER"

# Build the exact grammar revision paired with the fetched query snapshot.
# Usage: build <repo-url> <language> [<subdir-in-repo>]
build() {
	local url=$1 lang=$2 subdir=${3:-}
	local repo="$SRC/grammar-$lang"
	local revision
	revision=$(jq -er --arg lang "$lang" '.[$lang].revision' "$NVIM_TREESITTER/lockfile.json")

	echo ">>> $lang  ($url @ $revision)"
	git init --quiet "$repo"
	git -C "$repo" remote add origin "$url"
	git -C "$repo" fetch --depth=1 --quiet origin "$revision"
	git -C "$repo" checkout --detach --quiet FETCH_HEAD

	if [ -n "$subdir" ]; then
		(cd "$repo/$subdir" && tree-sitter build --output "$PARSER_DST/$lang.so")
	else
		(cd "$repo" && tree-sitter build --output "$PARSER_DST/$lang.so")
	fi
}

build https://github.com/tree-sitter/tree-sitter-bash bash
build https://github.com/tree-sitter/tree-sitter-c c
build https://github.com/tree-sitter/tree-sitter-css css
build https://github.com/tree-sitter/tree-sitter-html html
build https://github.com/tree-sitter/tree-sitter-javascript javascript
build https://github.com/tree-sitter/tree-sitter-json json
build https://github.com/tree-sitter-grammars/tree-sitter-lua lua
build https://github.com/tree-sitter-grammars/tree-sitter-markdown markdown tree-sitter-markdown
build https://github.com/tree-sitter-grammars/tree-sitter-markdown markdown_inline tree-sitter-markdown-inline
build https://github.com/tree-sitter/tree-sitter-python python
build https://github.com/tree-sitter/tree-sitter-typescript tsx tsx
build https://github.com/tree-sitter/tree-sitter-typescript typescript typescript
build https://github.com/tree-sitter-grammars/tree-sitter-vim vim
build https://github.com/neovim/tree-sitter-vimdoc vimdoc
build https://github.com/tree-sitter-grammars/tree-sitter-vue vue
build https://github.com/tree-sitter-grammars/tree-sitter-yaml yaml

QUERY_LANGUAGES=(
	bash
	c
	css
	ecma
	html
	html_tags
	javascript
	json
	jsx
	lua
	markdown
	markdown_inline
	python
	tsx
	typescript
	vim
	vimdoc
	vue
	yaml
)

echo ">>> Refreshing Neovim query files"
for lang in "${QUERY_LANGUAGES[@]}"; do
	source_dir="$NVIM_TREESITTER/queries/$lang"
	if [ ! -d "$source_dir" ]; then
		echo "ERROR: queries missing for $lang" >&2
		exit 1
	fi
	mkdir -p "$QUERY_DST/$lang"
	cp "$source_dir"/*.scm "$QUERY_DST/$lang/"
done

# The legacy nvim-treesitter master query uses a Lua directive supplied by the
# plugin. This standalone parser setup does not load that plugin, so use
# Neovim's native injection.language capture for fenced Markdown code blocks.
markdown_injections="$QUERY_DST/markdown/injections.scm"
sed -i \
	-e 's/(language) @_lang)/(language) @injection.language)/' \
	-e 's/(code_fence_content) @injection.content$/(code_fence_content) @injection.content)/' \
	-e '/(#set-lang-from-info-string! @_lang))/d' \
	"$markdown_injections"

if grep -q 'set-lang-from-info-string' "$markdown_injections"; then
	echo "ERROR: failed to make the Markdown injection query Neovim-compatible" >&2
	exit 1
fi

echo ">>> Done. Parsers in $PARSER_DST:"
ls "$PARSER_DST"
