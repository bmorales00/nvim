-- This file is responsible for setting up the keymaps

local mapkey = require("util.keymapper").mapvimkey

-- Buffer Navigation
mapkey("<leader>bn", "bnext", "n", { desc = "Next buffer" })
mapkey("<leader>bp", "bprevious", "n", { desc = "Previous buffer" })
mapkey("<leader>bd", "bdelete", "n", { desc = "Delete buffer" })
mapkey("<leader>bb", "e #", "n", { desc = "Alternate buffer" })
-- mapkey("<leader>`", "e #", "n") -- Switch to Other Buffer

-- Pane and Window Navigation
mapkey("<C-h>", "<C-w>h", "n", { desc = "Navigate left" })
mapkey("<C-j>", "<C-w>j", "n", { desc = "Navigate down" })
mapkey("<C-k>", "<C-w>k", "n", { desc = "Navigate up" })
mapkey("<C-l>", "<C-w>l", "n", { desc = "Navigate right" })
mapkey("<C-h>", "wincmd h", "t", { desc = "Navigate left" })
mapkey("<C-j>", "wincmd j", "t", { desc = "Navigate down" })
mapkey("<C-k>", "wincmd k", "t", { desc = "Navigate up" })
mapkey("<C-l>", "wincmd l", "t", { desc = "Navigate right" })
mapkey("<C-h>", "TmuxNavigateLeft", "n", { desc = "Navigate left across Tmux" })
mapkey("<C-j>", "TmuxNavigateDown", "n", { desc = "Navigate down across Tmux" })
mapkey("<C-k>", "TmuxNavigateUp", "n", { desc = "Navigate up across Tmux" })
mapkey("<C-l>", "TmuxNavigateRight", "n", { desc = "Navigate right across Tmux" })

-- Window Management
mapkey("<leader>sv", "vsplit", "n", { desc = "Vertical split" })
mapkey("<leader>sh", "split", "n", { desc = "Horizontal split" })
mapkey("<leader>ss", "wincmd x", "n", { desc = "Swap split" })
mapkey("<C-Up>", "resize +2", "n", { desc = "Increase window height" })
mapkey("<C-Down>", "resize -2", "n", { desc = "Decrease window height" })
mapkey("<C-Left>", "vertical resize +2", "n", { desc = "Increase window width" })
mapkey("<C-Right>", "vertical resize -2", "n", { desc = "Decrease window width" })

-- Show Full File-Path
mapkey("<leader>pa", "file", "n", { desc = "Show file path" })

-- Indenting
vim.keymap.set("v", "<", "<gv", { silent = true, noremap = true, desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { silent = true, noremap = true, desc = "Indent right" })

local api = vim.api

-- Escaping vim modes
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = false, desc = "Exit insert mode" })
vim.api.nvim_set_keymap("v", "jk", "<ESC>", { noremap = false, desc = "Exit visual mode" })

-- Comments

if vim.env.TMUX ~= nil then
	api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false, desc = "Toggle comment line" })
	api.nvim_set_keymap("v", "<C-_>", "gc", { noremap = false, desc = "Toggle comment selection" })
else
	api.nvim_set_keymap("n", "<C-/>", "gcc", { noremap = false, desc = "Toggle comment line" })
	api.nvim_set_keymap("v", "<C-/>", "gc", { noremap = false, desc = "Toggle comment selection" })
end

-- DAP (Debugger Adapter Protocol)
mapkey("<leader>db", "DapToggleBreakpoint", "n", { desc = "Toggle breakpoint" })
mapkey("<F5>", "DapContinue", "n", { desc = "Continue debugging" })
mapkey("<F6>", "DapStepOver", "n", { desc = "Step over" })
mapkey("<F7>", "DapStepInto", "n", { desc = "Step into" })
mapkey("<F8>", "DapStepOut", "n", { desc = "Step out" })
