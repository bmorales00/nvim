local get_file_info = function()
	if not package.loaded["mini.icons"] then
		return "Mini Icons is needed to use Icons in the Statusline"
	end
	local full_path = vim.api.nvim_buf_get_name(0)
	local extension = vim.fn.expand("%:e")
	local filetype = vim.bo.filetype

	if not filetype then
		filetype = "No Filetype for Current File"
	end

	local icon = MiniIcons.get("filetype", filetype)

	if not icon then
		icon = MiniIcons.get("extension", extension)
	end
	if not icon then
		icon = MiniIcons.get("file", full_path)
	end

	if not icon then
		return ""
	end
	return icon or "", filetype
end

local hl = function(group)
	return vim.api.nvim_get_hl(0, {
		name = group,
		link = false,
		create = false,
	})
end

-- SL = Statusline
local set_hl_groups = function()
	local base = hl("StatusLine")
	local base_bg = base.bg -- Original bg as per theme
	base.bg = "NONE" -- Transparent bg
	vim.api.nvim_set_hl(0, "StatusLine", base)

	for group, opts in pairs({
		ModeNormal = { fg = base_bg, bg = base.fg },
		ModePending = { fg = base_bg, bg = hl("Comment").fg },
		ModeVisual = { fg = base_bg, bg = hl("SpecialKey").fg },
		ModeInsert = { fg = base_bg, bg = hl("DiffAdded").fg },
		ModeCommand = { fg = base_bg, bg = hl("Number").fg },
		ModeReplace = { fg = base_bg, bg = hl("Constant").fg },
		Bold = { fg = base_bg, bg = base.fg },
		Dim = { fg = base_bg, bg = base.fg },
	}) do
		local group_name = "SL" .. group
		vim.api.nvim_set_hl(0, group_name, opts)
		vim.api.nvim_set_hl(0, group_name .. "Inverted", {
			fg = opts.bg,
			bg = "NONE",
		})
	end
end

set_hl_groups()

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("statusline", {}),
	desc = "Re-apply StatusLine Highlights on ColorScheme Change",
	callback = set_hl_groups,
})

local get_diagnostics_info = function()
	local config = vim.diagnostic.config()
	local signs = type(config.signs) == "table" and config.signs.text or {}
	local error_icon = signs[vim.diagnostic.severity.ERROR] or ""
	local warning_icon = signs[vim.diagnostic.severity.WARN] or ""
	local info_icon = signs[vim.diagnostic.severity.INFO] or ""
	local hint_icon = signs[vim.diagnostic.severity.HINT] or ""

	local result = {}

	local counts = vim.diagnostic.count(0)

	local errors = counts[vim.diagnostic.severity.ERROR] or 0
	local warnings = counts[vim.diagnostic.severity.WARN] or 0
	local information = counts[vim.diagnostic.severity.INFO] or 0
	local hints = counts[vim.diagnostic.severity.HINT] or 0

	if errors > 0 then
		table.insert(result, "%$DiagnosticError$" .. error_icon .. errors)
	end
	if warnings > 0 then
		table.insert(result, "%$DiagnosticWarn$" .. warning_icon .. warnings)
	end
	if information > 0 then
		table.insert(result, "%$DiagnosticInfo$" .. info_icon .. information)
	end
	if hints > 0 then
		table.insert(result, "%$DiagnosticHint$" .. hint_icon .. hints)
	end
	return table.concat(result, " ")
end

local mode_settings = {
	["n"] = { name = "NORMAL", hl = "Normal" },
	["no"] = { name = "OP-PENDING", hl = "Pending" },
	["nov"] = { name = "OP-PENDING", hl = "Pending" },
	["noV"] = { name = "OP-PENDING", hl = "Pending" },
	["no\22"] = { name = "OP-PENDING", hl = "Pending" },
	["niI"] = { name = "NORMAL", hl = "Normal" },
	["niR"] = { name = "NORMAL", hl = "Normal" },
	["niV"] = { name = "NORMAL", hl = "Normal" },
	["nt"] = { name = "NORMAL", hl = "Normal" },
	["ntT"] = { name = "NORMAL", hl = "Normal" },
	["v"] = { name = "VISUAL", hl = "Visual" },
	["vs"] = { name = "VISUAL", hl = "Visual" },
	["V"] = { name = "V-LINE", hl = "Visual" },
	["Vs"] = { name = "V-LINE", hl = "Visual" },
	["\22"] = { name = "V-BLOCK", hl = "Visual" },
	["\22s"] = { name = "V-BLOCK", hl = "Visual" },
	["s"] = { name = "SELECT", hl = "Insert" },
	["S"] = { name = "S-LINE", hl = "Normal" },
	["\19"] = { name = "S-BLOCK", hl = "Normal" },
	["i"] = { name = "INSERT", hl = "Insert" },
	["ic"] = { name = "INSERT", hl = "Insert" },
	["ix"] = { name = "INSERT", hl = "Insert" },
	["R"] = { name = "REPLACE", hl = "Replace" },
	["Rc"] = { name = "REPLACE", hl = "Replace" },
	["Rx"] = { name = "REPLACE", hl = "Replace" },
	["Rv"] = { name = "V-REPLACE", hl = "Replace" },
	["Rvc"] = { name = "V-REPLACE", hl = "Replace" },
	["Rvx"] = { name = "V-REPLACE", hl = "Replace" },
	["c"] = { name = "COMMAND", hl = "Command" },
	["cv"] = { name = "EX", hl = "Command" },
	["ce"] = { name = "EX", hl = "Command" },
	["r"] = { name = "REPLACE", hl = "Normal" },
	["rm"] = { name = "MORE", hl = "Normal" },
	["r?"] = { name = "CONFIRM", hl = "Normal" },
	["!"] = { name = "SHELL", hl = "Normal" },
	["t"] = { name = "TERMINAL", hl = "Command" },
}

local get_mode = function()
	return mode_settings[vim.fn.mode(1)] or { name = "UNKOWN", hl = "Normal" }
end

local diagnostic_component = function(mode)
	local diagnostics = get_diagnostics_info()
	if diagnostics == "" then
		return ""
	end

	local group = "%#SLMode" .. mode.hl

	local inverted = group .. "Inverted#"
	local normal = group .. "#"

	return table.concat({
		inverted .. " ",
		inverted .. "",
		normal,
		diagnostics,
		inverted .. "",
	})
end

local left_side_component = function(mode)
	local icon = "𒉭"

	return table.concat({
		"%#SLMode" .. mode.hl .. "Inverted" .. "#",
		"%#SLMode" .. mode.hl .. "# ",
		"%#SLMode" .. mode.hl .. "#" .. icon .. " " .. mode.name,
		"%#SLMode" .. mode.hl .. "# ",
		"%#SLMode" .. mode.hl .. "Inverted" .. "#",

		"%#SLMode" .. mode.hl .. "Inverted" .. "# ",

		"%#SLMode" .. mode.hl .. "Inverted" .. "#",
		"%#SLMode" .. mode.hl .. "# ",
		"%#SLMode" .. mode.hl .. "#" .. "%f %m",
		"%#SLMode" .. mode.hl .. "# ",
		"%#SLMode" .. mode.hl .. "Inverted" .. "#",
	})
end

local right_side_component = function(mode)
	local icon, filetype = get_file_info()

	return table.concat({
		"%#SLMode" .. mode.hl .. "Inverted" .. "#",
		"%#SLMode" .. mode.hl .. "# ",
		"%#SLMode" .. mode.hl .. "#" .. icon .. " " .. filetype,
		"%#SLMode" .. mode.hl .. "# ",
		"%#SLMode" .. mode.hl .. "Inverted" .. "#",

		"%#SLMode" .. mode.hl .. "Inverted" .. "# ",

		"%#SLMode" .. mode.hl .. "Inverted" .. "#",
		"%#SLMode" .. mode.hl .. "# ",
		"%#SLMode" .. mode.hl .. "#" .. "%l||%L",
		"%#SLMode" .. mode.hl .. "# ",
		"%#SLMode" .. mode.hl .. "Inverted" .. "#",
	})
end

local status = {}

function status.render()
	local current_mode = get_mode()
	return table.concat({
		left_side_component(current_mode),
		diagnostic_component(current_mode),
		"%=",
		right_side_component(current_mode),
	})
end

function status.setup()
	_G.statusline = status
	vim.opt.statusline = "%{%v:lua.statusline.render()%}"
end

return status
