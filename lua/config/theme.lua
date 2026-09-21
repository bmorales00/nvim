local M = {}

local data_home = vim.env.XDG_DATA_HOME
if not data_home or data_home == "" then
	data_home = vim.fn.expand("~/.local/share")
end
M.palette_path = data_home .. "/personal-system/neovim/active.json"

local function read_external_palette()
	local file, open_error = io.open(M.palette_path, "r")
	if not file then
		local uv = vim.uv or vim.loop
		if not uv.fs_stat(M.palette_path) then
			return nil, "missing"
		end
		return nil, "read_error", open_error
	end

	local contents = file:read("*a")
	file:close()

	local decoded, decode_error = pcall(vim.json.decode, contents)
	if not decoded then
		return nil, "decode_error", decode_error
	end
	return decode_error, "ok"
end

local function fallback(theme)
	local ok, err = theme.apply()
	if not ok then
		return nil, "could not apply the built-in Lackluster palette: " .. err
	end
	return true
end

local function apply_external(theme, palette)
	local valid, validation_error = theme.validate_palette(palette)
	if not valid then
		return nil, "external palette validation failed: " .. validation_error
	end

	local ok, apply_error = theme.apply(palette)
	if not ok then
		return nil, "external palette application failed: " .. apply_error
	end
	return true
end

local function notify_error(message)
	vim.schedule(function()
		vim.notify("ThemeReload: " .. message, vim.log.levels.ERROR)
	end)
end

function M.reload(opts)
	opts = opts or {}
	local theme = require("theme")
	local palette, status, read_error = read_external_palette()

	if status == "ok" then
		local ok, apply_error = apply_external(theme, palette)
		if ok or not opts.startup then
			return ok, apply_error
		end

		local fallback_ok, fallback_error = fallback(theme)
		if not fallback_ok then
			return nil, apply_error .. "\n" .. fallback_error
		end
		return nil, apply_error
	end

	if status == "missing" then
		return fallback(theme)
	end

	local message
	if status == "decode_error" then
		message = "could not decode " .. M.palette_path .. ": " .. read_error
	else
		message = "could not read " .. M.palette_path .. ": " .. read_error
	end

	if opts.startup then
		local ok, fallback_error = fallback(theme)
		if not ok then
			return nil, message .. "\n" .. fallback_error
		end
	end
	return nil, message
end

function M.setup()
	local ok, err = M.reload({ startup = true })
	if not ok and err then
		notify_error(err)
	end

	vim.api.nvim_create_user_command("ThemeReload", function()
		local reload_ok, reload_error = M.reload()
		if not reload_ok then
			notify_error(reload_error)
		end
	end, {
		desc = "Reload the external semantic Neovim palette",
	})
end

return M
