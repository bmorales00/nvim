local ok, ui2 = pcall(require, "vim._core.ui2")

if ok then
	ui2.enable({
		enable = true,
		msg = {
			target = "msg",
			targets = {
				[""] = "msg",
				empty = "cmd",
				progress = "msg",
				confirm = "cmd",
				echo = "msg",
				echomsg = "msg",
				completion = "cmd",

				emsg = "pager",
				echoerr = "pager",
				list_cmd = "pager",
				lua_error = "pager",
			},
			dialog = { height = 0.5 },
			msg = { height = 0.4 },
			pager = { height = 0.6 },
		},
	})

	-- HACK/EXPERIMENTAL: This relies on Neovim's internal UI2 API and may break after updates.
	if ui2.msg and ui2.msg.set_pos and not ui2._msg_top_right_wrapped then
		local original_set_pos = ui2.msg.set_pos

		ui2.msg.set_pos = function(target)
			original_set_pos(target)

			if target == nil or target == "msg" then
				local win = ui2.wins.msg
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_set_config(win, {
						relative = "editor",
						anchor = "NE",
						row = 1,
						col = vim.o.columns - 1,
					})
				end
			end
		end

		ui2._msg_top_right_wrapped = true
	end
end
