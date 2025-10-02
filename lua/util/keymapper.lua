-- This is a keymapper file for neovim configuration
local vim_modes = { -- Table for vim modes
	n = "n",
	i = "i",
	v = "v",
}

local default_opts = { -- Default options for keymaps
	noremap = true, -- Prevent recursive strokes
	silent = true, --Suppress command output
}

--- @param opts (table|nil)
--- @return table
local get_opts = function(opts) -- Merge user provided opt with default opt
	local all_opts = opts
	if all_opts == nil then
		all_opts = {}
	end
	for k, v in pairs(default_opts) do
		all_opts[k] = all_opts[k] or v
	end
	return all_opts
end

--- @param vimmode (string|nil)
--- @return string
local get_mode = function(vimmode) -- Converts short hand mode to full mode string
	local modeString = vim_modes[vimmode]
	if modeString == nil then
		return "n"
	else
		return modeString
	end
end

--- @param command (string)
--- @return string
local get_cmd_string = function(command) -- Wraps a command in <cmd> and <CR> for vim command exec
	return [[<cmd>]] .. command .. [[<CR>]] -- cmd being ':' and CR being 'enter key'
end

--- @param keymaps string
--- @param command string
--- @param vimmode (string|nil)
--- @param options (table|nil)
--- @return nil
local mapvimkey = function(keymaps, command, vimmode, options) -- Wraps command using vim.keymap.set
	local mode = get_mode(vimmode)
	local lhs = keymaps
	local rhs = get_cmd_string(command)
	local opts = get_opts(options)
	vim.keymap.set(mode, lhs, rhs, opts)
end

--- @param keymaps string
--- @param cmd (function|string)
--- @param desc (string|nil)
--- @return table
local maplazykey = function(keymaps, cmd, desc) -- Returns table for lazy plugin keymap
	if type(cmd) ~= "function" then -- Will load plugin if its lazy loaded when keymap is pressed
		cmd = get_cmd_string(cmd)
	end
	return { keymaps, cmd, desc = desc }
end

return {
	mapvimkey = mapvimkey,
	maplazykey = maplazykey,
}
