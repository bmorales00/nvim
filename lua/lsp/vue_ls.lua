--- works in hybrid mode alongside vtsls
--- When you are editing the <script> block of a .vue file,
--- Volar forwards the code and your actions (like asking for autocompletion)
--- to the vtsls server. vtsls processes it and sends the result back to Vue_ls, which then displays it in your editor.

--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	local tsdk_path = vim.fn.expand("$MASON/packages")
		.. "/vtsls/node_modules/@vtsls/language-server/node_modules/typescript/lib"

	vim.lsp.config("vue_ls", {
		capabilities = capabilities,
		cmd = { "vue-language-server", "--stdio", "--tsdk=" .. tsdk_path },
		on_init = function(client)
			local retries = 0

			local function typescript_handler(_, result, context)
				local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
				if #clients == 0 then
					if retries <= 10 then
						retries = retries + 1
						vim.defer_fn(function()
							typescript_handler(_, result, context)
						end, 100)
					else
						vim.notify(
							"Could not find `vtsls` lsp client, vue_lsp will not work without it!",
							vim.log.levels.ERROR
						)
					end
					return
				end
				local ts_client = clients[1]

				local param = unpack(result)
				local id, command, payload = unpack(param)
				ts_client:exec_cmd({
					title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
					command = "typescript.tsserverRequest",
					arguments = {
						command,
						payload,
					},
				}, { bufnr = context.bufnr }, function(_, r)
					local response_data = { { id, r and r.body } }
					---@diagnostic disable-next-line: param-type-mismatch
					client:notify("tsserver/response", response_data)
				end)
			end

			client.handlers["tsserver/request"] = typescript_handler
		end,
		----------------------------------------------------------------
		settings = {
			typescript = {
				inlayHints = {
					enumMemberValues = {
						enabled = true,
					},
					functionLikeReturnTypes = {
						enabled = true,
					},
					propertyDeclarationTypes = {
						enabled = true,
					},
					parameterTypes = {
						enabled = true,
						suppressWhenArgumentMatchesName = true,
					},
					variableTypes = {
						enabled = true,
					},
				},
			},
		},
	})
end
