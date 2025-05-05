-- Icons for the DAP and LSP
local M = {}

M.debugging_signs = {
	Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
	Breakpoint = " ",
	BreakpointCondition = " ",
	BreakpointRejected = { " ", "DiagnosticError" },
	LogPoint = ".>",
}

M.diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = {name = "ERROR", text = " ", hl = "DiagnosticError"},
  [vim.diagnostic.severity.WARN] = {name = "WARN", text = " ", hl = "DiagnosticWarn"},
  [vim.diagnostic.severity.HINT] = {name = "HINT", text = "",hl = "DiagnosticHint"},
  [vim.diagnostic.severity.INFO] = {name = "INFO", text = "", hl = "DiagnosticInfo"},

}

-- 	Error = " ",
-- 	Warn = " ",
-- 	Hint = "",
-- 	Info = "",
-- }

return M
