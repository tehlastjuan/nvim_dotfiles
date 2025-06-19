local methods = vim.lsp.protocol.Methods

return {

	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufNewFile" },
		dependencies = {
			{
				"mason-org/mason.nvim",
				keys = {
					{ "<leader>m", "<cmd>Mason<cr>", "n", { silent = true, desc = "Mason" } },
				},
				opts = {},
			},
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim", opts = {} },
		},
		opts = function()
			---@class PluginLspOpts
			local ret = {
				---@type vim.diagnostic.Opts
				diagnostics = require("diagnostics"),
				-----@type lspconfig.options
				servers = {
					lua_ls = {
						-- Use this to add any additional keymaps for specific lsp servers
						-- ---@type LazyKeysSpec[]
						-- keys = {},
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								codeLens = {
									enable = true,
								},
								completion = {
									callSnippet = "Replace",
								},
								doc = {
									privateName = { "^_" },
								},
								hint = {
									enable = true,
									setType = false,
									paramType = true,
									paramName = "Disable",
									semicolon = "Disable",
									arrayIndex = "Disable",
								},
							},
						},
					},
				},
			}

			return ret
		end,
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
					end

					map("<leader>br", vim.lsp.buf.rename, "Buffer Rename")
					map("ca", vim.lsp.buf.code_action, "Code Action")

					map("gD", vim.lsp.buf.declaration, "Goto Declaration")
					map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
					map("gr", require("telescope.builtin").lsp_references, "Goto References")
					map("gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
					map("gt", require("telescope.builtin").lsp_type_definitions, "Goto Type Definition")

					map("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
					map("<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

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

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client == nil then
						return
					end

					--- Sets up LSP highlights for the given buffer.
					if client:supports_method(methods.textDocument_documentHighlight) then
						local under_cursor_highlights_group =
							vim.api.nvim_create_augroup("under_cursor_highlights", { clear = false })

						vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
							group = under_cursor_highlights_group,
							desc = "Highlight references under the cursor",
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
							group = under_cursor_highlights_group,
							desc = "Clear highlight references",
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "under_cursor_highlights", buffer = event2.buf })
							end,
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
										uri = vim.uri_from_bufnr(event.buf),
										version = vim.lsp.util.buf_versions[event.buf],
									},
								},
							}, nil, event.buf)
						end, { desc = "Fix all ESLint errors", buffer = event.buf })
					end
				end,
			})

			local servers = opts.servers
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local has_blink, blink = pcall(require, "blink.cmp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				has_blink and blink.get_lsp_capabilities() or {},
				opts.capabilities or {}
			)

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- defaults
				"prettier",
				"prettierd",
				"dprint",
				-- bash
				"bash-language-server",
				"shellcheck",
				"shfmt",
				-- c
				"clangd",
				"clang-format",
				-- cmake
				"cmakelang",
				"cmakelint",
				-- css
				"css-lsp",
				"stylelint-lsp",
				"stylelint",
				-- docker
				"hadolint",
				-- html
				"html-lsp",
				-- javascript/typescript
				"vtsls",
				"eslint-lsp",
				-- json
				"json-lsp",
				-- lua
				"lua-language-server",
				"stylua",
				-- markdown
				"markdownlint-cli2",
				"markdown-toc",
				-- php
				-- "intelephense",
				-- "php-cs-fixer",
				-- python
				"pyright",
				"ruff",
				-- toml
				--"taplo",
				-- yaml
				"yaml-language-server",
				"yamllint",
				"yq",
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			---@type MasonLspconfigSettings
			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_enable = true,
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	-- json/yaml schema support
	{ "b0o/SchemaStore.nvim", lazy = true },

	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
}
