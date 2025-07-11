-- Auto-Format on Save
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		local efm = vim.lsp.get_clients({ name = "efm" })

		if vim.tbl_isempty(efm) then
			return
		end

		vim.lsp.buf.format({ name = "efm", async = true })
	end,
})

-- Highlights text with Yank
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYankGroup", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	callback = function()
		vim.highlight.on_yank()
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
--
--
-- -- Change HTML files to HTMLAngular within an angular repo
--
-- local detect_html_to_ng = vim.api.nvim_create_augroup("AngularHtmlDetect", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
-- 	group = detect_html_to_ng,
-- 	pattern = "*.html",
-- 	callback = function(args)
-- 		local bufnr = args.buf
--
-- 		-- Get the current filetype. Only proceed if it's 'html' or 'htmlangular'
-- 		-- This prevents overriding other specific HTML-like filetypes (e.g., htmldjango, htmljinja)
-- 		if vim.bo[bufnr].filetype == "html" or vim.bo[bufnr].filetype == "htmlangular" then
-- 			local filepath = vim.api.nvim_buf_get_name(bufnr)
-- 			local dirname = vim.fn.fnamemodify(filepath, ":h")
--
-- 			-- Strategy 1: Check for `angular.json` in parent directories
-- 			-- This is the most reliable way to identify an Angular project
-- 			local angular_json_path = vim.fn.findfile("angular.json", dirname .. ";")
--
-- 			if angular_json_path ~= "" then
-- 				-- If angular.json is found, it's an Angular project. Set filetype to htmlangular.
-- 				vim.bo[bufnr].filetype = "htmlangular"
-- 				print("Filetype set to htmlangular (angular.json detected) for buffer " .. bufnr)
-- 				return
-- 			end
--
-- 			-- Strategy 2: If no angular.json, check file content for Angular-specific syntax
-- 			-- This handles cases where angular.json might be far up, or for inline templates (though less common in .html files)
-- 			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false) -- Read all lines for robust check
--
-- 			for _, line in ipairs(lines) do
-- 				-- More comprehensive regex for Angular template syntax
-- 				if
-- 					line:match("{{.*}}") -- String interpolation
-- 					or line:match("*ng") -- Structural directives (*ngIf, *ngFor)
-- 					or line:match("%[%(.*%)%]") -- Event binding ([()=]) or property binding ([])
-- 					or line:match("<ng%-") -- Angular elements like <ng-template>, <ng-container>
-- 					or line:match("@if") -- Angular's new control flow
-- 					or line:match("@for")
-- 					or line:match("@switch")
-- 				then
-- 					vim.bo[bufnr].filetype = "htmlangular"
-- 					print("Filetype set to htmlangular (Angular syntax detected) for buffer " .. bufnr)
-- 					return
-- 				end
-- 			end
-- 		end
-- 	end,
-- })
