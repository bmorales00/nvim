return {
	"saghen/blink.cmp",
	-- Note: blink.cmp provides its own release tags
	version = "*",
	dependencies = {
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip/loaders/from_vscode").lazy_load()
		end,
	},

	opts = {
		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
				-- You can add custom cmdline maps here if needed
			},
			completion = {
				menu = { auto_show = false },
				ghost_text = { enabled = true },
			},
		},
		snippets = { preset = "luasnip" },

		-- Keymaps: matching your nvim-cmp setup
		keymap = {
			preset = "none", -- We'll define them manually to match your C-j/C-k style
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },

			["<C-k>"] = { "select_prev", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<Down>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			-- nerd_font_variant = "mono",
		},

		completion = {
			menu = {
				border = "rounded",
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
				},
			},
			documentation = {
				auto_show = true,
				window = { border = "rounded" },
			},
			-- Equivalent to your entry_filter (filtering out "Text" from LSP)
			list = {
				selection = { preselect = false, auto_insert = true },
			},
		},

		-- Sources: Replacing all the individual cmp-xxx plugins
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					-- Replicating your entry_filter for "Text"
					transform_items = function(_, items)
						return vim.tbl_filter(function(item)
							return item.kind ~= vim.lsp.protocol.CompletionItemKind.Text
						end, items)
					end,
				},
			},
		},
	},
}
