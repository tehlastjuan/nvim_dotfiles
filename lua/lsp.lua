local M = {}

--- Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
	---@param lhs string
	---@param rhs string|function
	---@param opts string|vim.keymap.set.Opts
	---@param mode? string|string[]
	local function map(lhs, rhs, opts, mode)
		mode = mode or "n"
		---@cast opts vim.keymap.set.Opts
		opts = type(opts) == "string" and { desc = opts } or opts
		opts.buffer = bufnr
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	map("[e", function()
		vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
	end, "Previous error")
	map("]e", function()
		vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
	end, "Next error")

	map("<leader>br", vim.lsp.buf.rename, "Buffer Rename")
	map("ca", vim.lsp.buf.code_action, "Code Action")
	map("gD", vim.lsp.buf.declaration, "Goto Declaration")

	--if client:supports_method 'textDocument/codeAction' then
	--  require('lightbulb').attach_lightbulb(bufnr, client)
	--end

	-- Don't check for the capability here to allow dynamic registration of the request.
	-- if client:supports_method 'textDocument/documentColor' then
	--   vim.lsp.document_color.enable(true, bufnr)
	--     map('grc', function()
	--       vim.lsp.document_color.color_presentation()
	--     end, 'vim.lsp.document_color.color_presentation()', { 'n', 'x' })
	-- end

	if client:supports_method("textDocument/references") then
		map("gr", require("telescope.builtin").lsp_references, "Goto References")
		map("gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
	end

	if client:supports_method("textDocument/typeDefinition") then
		map("gt", require("telescope.builtin").lsp_type_definitions, "Goto Type Definition")
	end

	if client:supports_method("textDocument/documentSymbol") then
		map("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
		map("<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
	end

	if client:supports_method("textDocument/definition") then
		map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
	end

	if client:supports_method("textDocument/signatureHelp") then
		map("<C-k>", function()
			-- Close the completion menu first (if open).
			if require("blink.cmp.completion.windows.menu").win:is_open() then
				require("blink.cmp").hide()
			end

			vim.lsp.buf.signature_help()
		end, "Signature help", "i")
	end

	--- Sets up LSP highlights for the given buffer.
	if client:supports_method("textDocument_documentHighlight") then
		local under_cursor_highlights_group =
      vim.api.nvim_create_augroup("tehlastjuan/under_cursor_highlights", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
			group = under_cursor_highlights_group,
			desc = "Highlight references under the cursor",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
			group = under_cursor_highlights_group,
			desc = "Clear highlight references",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end

	-- Add "Fix all" command for ESLint.
	if client.name == "eslint" or client.name == "styleint_lsp" then
		vim.keymap.set("n", "<leader>ce", function()
			if not client then
				return
			end

			client:request(vim.lsp.protocol.Methods.workspace_executeCommand, {
				command = "eslint.applyAllFixes",
				arguments = {
					{
						uri = vim.uri_from_bufnr(bufnr),
						version = vim.lsp.util.buf_versions[bufnr],
					},
				},
			}, nil, bufnr)
		end, { desc = "Fix all ESLint errors", buffer = bufnr })
	end

	-- workaround for gopls not supporting semanticTokensProvider
	-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
	if client.name == "gopls" then
		if not client then
			return
		end

		if not client.server_capabilities.semanticTokensProvider then
			local semantic = client.config.capabilities.textDocument.semanticTokens
			if semantic == nil then
				return
			end
			client.server_capabilities.semanticTokensProvider = {
				full = true,
				legend = {
					tokenTypes = semantic.tokenTypes,
					tokenModifiers = semantic.tokenModifiers,
				},
				range = true,
			}
		end
	end
end

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
	return hover({
		border = "single",
		max_height = math.floor(vim.o.lines * 0.5),
		max_width = math.floor(vim.o.columns * 0.4),
	})
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
	return signature_help({
		border = "single",
		max_height = math.floor(vim.o.lines * 0.5),
		max_width = math.floor(vim.o.columns * 0.4),
	})
end

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers["client/registerCapability"]
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if not client then
		return
	end

	on_attach(client, vim.api.nvim_get_current_buf())
	return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Configure LSP keymaps",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- I don't think this can happen but it's a wild world out there.
		if not client then
			return
		end
		on_attach(client, args.buf)
	end,
})

-- Set up LSP servers.
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
    -- Extend neovim's client capabilities with the completion ones.
		vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })

    ---@type MasonLspconfigSettings
    -- require("mason-lspconfig").setup()

		local servers = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
			:map(function(file)
				return vim.fn.fnamemodify(file, ":t:r")
			end)
			:totable()
		vim.lsp.enable(servers)
	end,
})

-- HACK: Override buf_request to ignore notifications from LSP servers that don't implement a method.
local buf_request = vim.lsp.buf_request
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf_request = function(bufnr, method, params, handler)
	return buf_request(bufnr, method, params, handler, function() end)
end

return M
