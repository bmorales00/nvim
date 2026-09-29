-- Git decorations used for added, removed, and changed lines
-- This plugin is used to show git decorations in the sign column
-- The sign column is the column on the left side of the buffer where line numbers are displayed
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, "Next Git hunk")

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, "Previous Git hunk")

				map("n", "<leader>vd", function()
					gitsigns.diffthis(nil, { vertical = true })
				end, "Diff against index")
				map("n", "<leader>vD", function()
					gitsigns.diffthis("~", { vertical = true })
				end, "Diff against last commit")
				map("n", "<leader>vp", gitsigns.preview_hunk, "Preview Git hunk")
				map("n", "<leader>vb", function()
					gitsigns.blame_line({ full = true })
				end, "Blame current line")
				map("n", "<leader>vs", gitsigns.stage_hunk, "Stage Git hunk")
				map("n", "<leader>vr", gitsigns.reset_hunk, "Reset Git hunk")
				map("n", "<leader>vS", gitsigns.stage_buffer, "Stage Git buffer")
				map("n", "<leader>vR", gitsigns.reset_buffer, "Reset Git buffer")

				map("v", "<leader>vs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage selected Git hunk")
				map("v", "<leader>vr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset selected Git hunk")
			end,
		})
	end,
}
