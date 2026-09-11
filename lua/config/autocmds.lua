local on_attach = require("util.lsp").on_attach

-- Detect Yaml in Ansible
vim.filetype.add({
	pattern = {
		[".*%.ya?ml"] = {
			function(path)
				local directory = vim.fs.dirname(path)
				if vim.fs.root(directory, { "ansible.cfg", ".ansible-lint" }) then
					return "yaml.ansible"
				end
			end,
			{ priority = 10 },
		},
	},
})

-- Auto-Format on Save
local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local lsp_formatters = {
			c = "clangd",
			cpp = "clangd",
			cuda = "clangd",
			objc = "clangd",
			objcpp = "clangd",
			css = "efm",
			html = "efm",
			javascript = "efm",
			javascriptreact = "efm",
			json = "efm",
			jsonc = "efm",
			less = "efm",
			lua = "efm",
			python = "efm",
			scss = "efm",
			sh = "efm",
			typescript = "efm",
			typescriptreact = "efm",
			vue = "efm",
			yaml = "yamlls",
		}
		local formatter = lsp_formatters[ft]
		if not formatter then
			return
		end

		local clients = vim.lsp.get_clients({ bufnr = args.buf, name = formatter })

		if vim.tbl_isempty(clients) then
			return
		end

		vim.lsp.buf.format({
			bufnr = args.buf,
			name = formatter,
			async = false,
			timeout_ms = 3000,
		})
	end,
})

-- Highlights text with Yank
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYankGroup", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- Restore cursor to file position in previous editing session
local return_last_pos = vim.api.nvim_create_augroup("LastPosGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = return_last_pos,
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

-- on attach function
local lsp_on_attach_group = vim.api.nvim_create_augroup("LspMappings", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_on_attach_group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			on_attach(client, args.buf)
		end
	end,
})

-- Treesitter highlighting
vim.treesitter.language.register("bash", { "bash", "sh" })
vim.treesitter.language.register("javascript", "javascriptreact")
vim.treesitter.language.register("json", "jsonc")
vim.treesitter.language.register("markdown", "markdown.mdx")
vim.treesitter.language.register("tsx", "typescriptreact")
vim.treesitter.language.register("yaml", "yaml.ansible")

local ts_group = vim.api.nvim_create_augroup("TreesitterAttach", {})
vim.api.nvim_create_autocmd("FileType", {
	group = ts_group,
	pattern = {
		"lua",
    "go",
    "gomod",
    "gowork",
		"python",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"html",
		"css",
		"json",
		"jsonc",
		"markdown",
		"markdown.mdx",
		"sh",
		"bash",
		"c",
		"vim",
		"vimdoc",
		"yaml",
		"yaml.ansible",
	},
	callback = function(args)
		local ok, err = pcall(vim.treesitter.start, args.buf)
		if not ok then
			vim.notify_once(
				("Treesitter failed for %s: %s"):format(vim.bo[args.buf].filetype, err),
				vim.log.levels.WARN
			)
		end
	end,
})
