local M = {}

local function is_package(path)
	return vim.uv.fs_stat(vim.fs.joinpath(path, "package.json")) ~= nil
end

local function node_modules_root(executable_path)
	local root = executable_path:match("^(.*[/\\]node_modules)[/\\]%.bin[/\\]")
	if root then
		return root
	end

	local resolved_path = vim.fn.resolve(executable_path)
	return resolved_path:match("^(.-[/\\]node_modules)[/\\]")
end

--- Find an npm package from one of its executables without assuming an installer.
--- @param executable string
--- @param package_name string
--- @return string
function M.package_root(executable, package_name)
	local executable_path = vim.fn.exepath(executable)
	if executable_path == "" then
		error(("Executable not found: %s"):format(executable))
	end

	local node_modules = node_modules_root(executable_path)
	if node_modules then
		local candidate = vim.fs.joinpath(node_modules, package_name)
		if is_package(candidate) then
			return candidate
		end
	end

	local resolved_path = vim.fn.resolve(executable_path)
	local package_marker = "/node_modules/" .. package_name .. "/"
	local _, package_end = resolved_path:find(package_marker, 1, true)
	if package_end then
		return resolved_path:sub(1, package_end - 1)
	end

	if node_modules then
		local suffix = vim.fs.joinpath("node_modules", package_name, "package.json")
		for _, package_json in
			ipairs(vim.fs.find("package.json", {
				path = node_modules,
				type = "file",
				limit = math.huge,
			}))
		do
			if package_json:sub(-#suffix) == suffix then
				return vim.fs.dirname(package_json)
			end
		end
	end

	error(("Could not locate npm package %s from %s"):format(package_name, executable_path))
end

--- Return a directory TypeScript can use to resolve an npm package by name.
--- @param executable string
--- @param package_name string
--- @return string
function M.package_search_path(executable, package_name)
	local package_root = M.package_root(executable, package_name)
	return package_root:sub(1, -#package_name - 2)
end

return M
