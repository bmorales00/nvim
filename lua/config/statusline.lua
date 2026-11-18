-- Powerline round caps used by the pill components below
local LEFT_CAP = "\238\130\182" -- U+E0B6
local RIGHT_CAP = "\238\130\180" -- U+E0B4
local BRANCH_ICON = "\238\130\160" -- U+E0A0

--- @return string icon, string filetype
local get_file_info = function()
	local filetype = vim.bo.filetype
	-- Statusline can render before lazy has loaded mini.nvim (e.g. startup error prompts)
	if not package.loaded["mini.icons"] then
		return "", filetype
	end

	-- MiniIcons.get never returns nil; it flags its generic fallback with is_default
	local icon, _, is_default = MiniIcons.get("filetype", filetype)
	if is_default then
		local full_path = vim.api.nvim_buf_get_name(0)
		if full_path ~= "" then
			icon = MiniIcons.get("file", full_path) -- covers extension and exact filename
		end
	end
	return icon, filetype
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
		Recording = { fg = base_bg, bg = hl("DiagnosticError").fg },
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

-- reg_recording() changes don't trigger a statusline redraw on their own.
-- Scheduled so RecordingLeave sees reg_recording() already cleared.
vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
	group = vim.api.nvim_create_augroup("statusline_recording", {}),
	desc = "Redraw statusline when macro recording starts or stops",
	callback = function()
		vim.schedule(function()
			vim.cmd.redrawstatus()
		end)
	end,
})

-- gitsigns only fires User GitSignsUpdate when hunk counts or branch change; it doesn't redraw.
vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("statusline_git", {}),
	pattern = "GitSignsUpdate",
	desc = "Redraw statusline when gitsigns status changes",
	callback = function()
		vim.cmd.redrawstatus()
	end,
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
	["s"] = { name = "SELECT", hl = "Visual" },
	["S"] = { name = "S-LINE", hl = "Visual" },
	["\19"] = { name = "S-BLOCK", hl = "Visual" },
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
	["cr"] = { name = "COMMAND", hl = "Command" },
	["cvr"] = { name = "EX", hl = "Command" },
	["r"] = { name = "PROMPT", hl = "Normal" },
	["rm"] = { name = "MORE", hl = "Normal" },
	["r?"] = { name = "CONFIRM", hl = "Normal" },
	["!"] = { name = "SHELL", hl = "Normal" },
	["t"] = { name = "TERMINAL", hl = "Command" },
}

local get_mode = function()
	return mode_settings[vim.fn.mode(1)] or { name = "UNKNOWN", hl = "Normal" }
end

-- Macro recording indicator (hidden by cmdheight = 0)
local recording_component = function()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	end

	return table.concat({
		"%#SLRecordingInverted# ",
		"%#SLRecordingInverted#" .. LEFT_CAP,
		"%#SLRecording# REC @" .. reg .. " ",
		"%#SLRecordingInverted#" .. RIGHT_CAP,
	})
end

-- Branch and hunk counts from gitsigns (vim.b.gitsigns_status_dict is unset outside git repos)
local git_component = function(mode)
	local status = vim.b.gitsigns_status_dict
	if not status or not status.head or status.head == "" then
		return ""
	end

	local parts = { BRANCH_ICON .. " " .. status.head }
	if (status.added or 0) > 0 then
		table.insert(parts, "%$GitSignsAdd$+" .. status.added)
	end
	if (status.changed or 0) > 0 then
		table.insert(parts, "%$GitSignsChange$~" .. status.changed)
	end
	if (status.removed or 0) > 0 then
		table.insert(parts, "%$GitSignsDelete$-" .. status.removed)
	end

	local group = "%#SLMode" .. mode.hl
	local inverted = group .. "Inverted#"
	local normal = group .. "#"

	return table.concat({
		inverted .. " ",
		inverted .. LEFT_CAP,
		normal .. " ",
		normal .. table.concat(parts, " "),
		normal .. " ",
		inverted .. RIGHT_CAP,
	})
end

-- Search position (hidden by cmdheight = 0; ui2 drops the built-in [x/y])
local search_component = function(mode)
	if vim.v.hlsearch == 0 then
		return ""
	end
	local ok, sc = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 50 })
	if not ok or sc.total == 0 then
		return ""
	end

	-- incomplete: 1 = timed out, 2 = more than maxcount matches
	local text = sc.incomplete == 1 and "?/??"
		or string.format("%d/%d%s", sc.current, sc.total, sc.incomplete == 2 and "+" or "")

	local group = "%#SLMode" .. mode.hl
	return table.concat({
		group .. "Inverted#" .. LEFT_CAP,
		group .. "# " .. text .. " ",
		group .. "Inverted#" .. RIGHT_CAP,
		group .. "Inverted# ",
	})
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
		-- %< truncates the path first when the line is too narrow; %m only gets a space when it shows
		"%#SLMode" .. mode.hl .. "#" .. "%<%f" .. ((vim.bo.modified or not vim.bo.modifiable) and " %m" or ""),
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
		git_component(current_mode),
		recording_component(),
		"%=",
		search_component(current_mode),
		right_side_component(current_mode),
	})
end

function status.setup()
	_G.statusline = status
	vim.opt.statusline = "%{%v:lua.statusline.render()%}"
end

return status
