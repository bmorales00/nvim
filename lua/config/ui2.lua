local ok, ui2 = pcall(require, "vim._core.ui2")

if ok then
	ui2.enable({
		enable = true,
		msg = {
			targets = {
				[""] = "msg",
				empty = "cmd",
				bufwrite = "msg",
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
end
