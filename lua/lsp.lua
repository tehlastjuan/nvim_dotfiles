local diagnostic_icons = require("icons").icons.diagnostics
local methods = vim.lsp.protocol.Methods
local utils = require("lsp-utils")

local M = {}

M._keys = nil

-- Disable inlay hints
vim.g.inlay_hints = false

function M.get()
	if M._keys then
		return M._keys
	end
  -- stylua: ignore
	M._keys = {
		{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },

		--{ "K", vim.lsp.buf.hover, desc = "Hover" },

		{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, { has = "codeAction" } },
		{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename", { has = "rename" } },

    { "<c-k>", (function()
        -- Close the completion menu first (if open).
        if require("blink.cmp.completion.windows.menu").win:is_open() then
          require("blink.cmp").hide()
        end
        vim.lsp.buf.signature_help()
      end), mode = "i", desc = "Signature help", { has = "signatureHelp" }
    },

    { "gk", (function()
        if require("blink.cmp.completion.windows.menu").win:is_open() then
          require("blink.cmp").hide()
        end
        vim.lsp.buf.signature_help()
      end), desc = "Signature help", { has = "signatureHelp" }
    },

		--{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help", { has = "signatureHelp" } },
		--{ "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", { has = "signatureHelp" } },
	}

	return M._keys
end

---@param buffer integer
---@param method string|string[]
function M.has(buffer, method)
	if type(method) == "table" then
		for _, m in ipairs(method) do
			if M.has(buffer, m) then
				return true
			end
		end
		return false
	end
	method = method:find("/") and method or "textDocument/" .. method
	local clients = utils.get_clients({ bufnr = buffer })
	for _, client in ipairs(clients) do
		if client.supports_method(method, buffer) then
			return true
		end
	end
	return false
end

function M.resolve(buffer)
	local Keys = require("lazy.core.handler.keys")
	if not Keys.resolve then
		return {}
	end
	local spec = M.get()
	local opts = vim.lsp._enabled_configs
	local clients = utils.get_clients({ bufnr = buffer })
	for _, client in ipairs(clients) do
		local maps = opts[client.name] and opts[client.name].keys or {}
		vim.list_extend(spec, maps)
	end
	return Keys.resolve(spec)
end

--- Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
function M.on_attach(client, bufnr)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = M.resolve()

	for _, keys in pairs(keymaps) do
		local has = not keys.has or M.has(bufnr, keys.has)
		local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

		if has and cond then
			local opts = Keys.opts(keys)
			opts.cond = nil
			opts.has = nil
			opts.silent = opts.silent ~= false
			opts.buffer = bufnr
			vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
		end
	end

  M.attach_highlights(client, bufnr)
end

--- Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
	---@param lhs string
	---@param rhs string|function
	---@param mode? string|string[]
	---@param opts? {}
	local function keymap(lhs, rhs, mode, desc, opts)
		local mapOpts = opts or {}

		local has = not mapOpts.has or M.has(bufnr, mapOpts.has)
		local cond = not (mapOpts.cond == false or ((type(mapOpts.cond) == "function") and not mapOpts.cond()))

		if has and cond then
			mapOpts.cond = nil
			mapOpts.has = nil
			mapOpts.desc = desc
			mapOpts.buffer = bufnr
			vim.keymap.set(mode or "n", lhs, rhs, mapOpts)
		end
	end

	--require('lightbulb').attach_lightbulb(bufnr, client.id)
	--vim.lsp.document_color.enable(true, bufnr)

	----- fzf-lua -----
	--keymap("ca", function()
	--	-- Use "silent" to avoid the warning about `vim.ui.select` not being registered with fzf-lua.
	--	-- I do this dynamically when first calling `vim.ui.select`.
	--	require("fzf-lua").lsp_code_actions({ silent = true })
	--end, "Code Action", { "n", "x" })

	--keymap("gr", "<cmd>FzfLua lsp_references<cr>", "Get references in buffer")
	--keymap("gy", "<cmd>FzfLua lsp_typedefs<cr>", "Go to type definition")
	--keymap("<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", "Document symbols")

	--if client:supports_method(methods.textDocument_definition) then
	--	keymap("gd", function()
	--		require("fzf-lua").lsp_definitions({ jump1 = true })
	--	end, "Go to definition")

	--	keymap("gD", function()
	--		require("fzf-lua").lsp_definitions({ jump1 = false })
	--	end, "Peek definition")
	--end

	----- telescope -----
	--keymap("ca", function() require("telescope.builtin").lsp_code_actions({ silent = true }) end, "Code Action", { "n", "x" })

	-- Use "silent" to avoid the warning about `vim.ui.select` not being registered with fzf-lua.
	-- I do this dynamically when first calling `vim.ui.select`.
	--keymap("ca", vim.lsp.buf.code_action, { "n", "x" }, { desc = "Code Action", silent = true })

	--keymap("<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })

	--keymap("gr", "<cmd>Telescope lsp_references<cr>", { desc = "References", nowait = true })

	--keymap("gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { desc = "Goto Implementation" })

	--keymap("gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { desc = "Goto T[y]pe Definition" })

	--keymap("<leader>fs", function() require("telescope.builtin").lsp_symbols({ reuse_win = true }) end, "Document symbols")

	--if client:supports_method(methods.textDocument_definition) then
	--	keymap("gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "Goto Definition" })
	--	keymap("gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
	--end

	--keymap("K", vim.lsp.buf.hover, "Hover")

	--keymap("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous diagnostic")
	--keymap("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
	--keymap("[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, "Previous error")
	--keymap("]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, "Next error")

	if client:supports_method(methods.textDocument_signatureHelp) then
		keymap("<c-k>", function()
			-- Close the completion menu first (if open).
			if require("blink.cmp.completion.windows.menu").win:is_open() then
				require("blink.cmp").hide()
			end
			vim.lsp.buf.signature_help()
		end, "i", { desc = "Signature help" })

		keymap("gk", function()
			if require("blink.cmp.completion.windows.menu").win:is_open() then
				require("blink.cmp").hide()
			end
			vim.lsp.buf.signature_help()
		end, { desc = "Signature help" })

		--keymap("<c-k>", vim.lsp.buf.signature_help, "i", "Signature Help", { has = "signatureHelp" })
		--keymap("gk", vim.lsp.buf.signature_help, "Signature Help", { has = "signatureHelp" })
	end

  M.attach_highlights(client, bufnr)
end

--- Sets up LSP highlights for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
function M.attach_highlights(client, bufnr)
	if client:supports_method(methods.textDocument_documentHighlight) then
		local under_cursor_highlights_group =
			vim.api.nvim_create_augroup("tehlastjuan/cursor_highlights", { clear = false })
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
	if client.name == "eslint" then
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
end

-- Define the diagnostic signs.
for severity, icon in pairs(diagnostic_icons) do
	local hl = "DiagnosticSign" .. severity:sub(1, 1) .. severity:sub(2):lower()
	vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- Diagnostic configuration.
vim.diagnostic.config({
	underline = false,
	virtual_text = false,
	virtual_lines = false,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_icons.Warn,
			[vim.diagnostic.severity.HINT] = diagnostic_icons.Hint,
			[vim.diagnostic.severity.INFO] = diagnostic_icons.Info,
		},
	},
	update_in_insert = false,
	severity_sort = true,
	jump = { float = true },
	inlay_hints = { enabled = false },
	codelens = { enabled = false },
	document_highlight = { enabled = true },
	capabilities = {
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
		},
	},
})

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
	return hover({
		max_height = math.floor(vim.o.lines * 0.5),
		max_width = math.floor(vim.o.columns * 0.4),
	})
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
	return signature_help({
		max_height = math.floor(vim.o.lines * 0.5),
		max_width = math.floor(vim.o.columns * 0.4),
	})
end

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if not client then
		return
	end

	M.on_attach(client, vim.api.nvim_get_current_buf())
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

		M.on_attach(client, args.buf)
	end,
})

-- Set up LSP servers.
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		local server_configs = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
			:map(function(file)
				return vim.fn.fnamemodify(file, ":t:r")
			end)
			:totable()
		vim.lsp.enable(server_configs)
	end,
})

return M
