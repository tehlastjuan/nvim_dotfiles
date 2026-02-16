local ensure_installed = {
	-- -- defaults
	"prettier",
	"prettierd",
	"dprint",
  "ast-grep",
	-- -- assembler
	-- "asm-lsp",
	-- -- bash
	"bash-language-server",
	"shellcheck",
	"shfmt",
	-- -- c
	"clangd",
	"clang-format",
	-- "csharp-language-server",
	-- -- cmake
	"cmakelang",
	"cmakelint",
	-- -- css
	"css-lsp",
	"stylelint",
	"stylelint-lsp",
	-- -- docker
	"hadolint",
	-- -- go
	"gopls",
	"gofumpt",
	"golines",
	"goimports",
	-- -- html
	"html-lsp",
	-- javascript/typescript
	"vtsls",
	"eslint-lsp",
	-- -- json
	"json-lsp",
	-- -- lua
	-- "lua-language-server",
	"stylua",
	-- -- markdown
	"markdownlint-cli2",
	"markdown-toc",
	-- -- php
	"intelephense",
	"php-cs-fixer",
	-- -- ruby
	-- "rubocop",
	-- -- rust
	"rust-analyzer",
	-- -- sql
	"sqruff",
	-- -- python
	"pyright",
	"ruff",
	-- -- toml
	"taplo",
	-- -- yaml
	"yaml-language-server",
	"yamllint",
	-- -- "yq",
}

return {
	-- lspconfig

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
		},
		opts_extend = { "servers.*.keys" },
		opts = function()
			-- LSP Server Settings
			-- Sets the default configuration for an LSP client (or all clients if the special name "*" is used).
			local ret = {
				servers = {
					-- configuration for all lsp servers
					["*"] = {
						capabilities = {
							workspace = {
								fileOperations = {
									didRename = true,
									willRename = true,
								},
							},
						},
					},
					stylua = { enabled = false },
					lua_ls = {
						mason = false,
						-- for specific lsp servers
						-- keys = {},
						settings = {
							Lua = {
								codeLens = { enable = true },
								completion = { callSnippet = "Replace" },
								doc = { privateName = { "^_" } },
								format = { enable = false },
								hint = {
									enable = true,
									setType = false,
									paramType = true,
									paramName = "Disable",
									semicolon = "Disable",
									arrayIndex = "Disable",
								},
								runtime = { version = "LuaJIT" },
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
										"${3rd}/luv/library",
									},
								},
							},
						},
					},
				},
				---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
				setup = {
					-- example to setup with typescript.nvim
					-- tsserver = function(_, opts)
					--   require("typescript").setup({ server = opts })
					--   return true
					-- end,
					-- Specify * to use this function as a fallback for any server
					-- ["*"] = function(server, opts) end,
				},
			}
			return ret
		end,
		config = vim.schedule_wrap(function(_, opts)
			if opts.capabilities then
				opts.servers["*"] = vim.tbl_deep_extend("force", opts.servers["*"] or {}, {
					capabilities = opts.capabilities,
				})
			end

			if opts.servers["*"] then
				vim.lsp.config("*", opts.servers["*"])
			end

			-- get all the servers that are available through mason-lspconfig
			local mason_all = vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
				or {} --[[ @as string[] ]]

			---@return boolean? exclude automatic setup
			local function configure(server)
				if server == "*" then
					return false
				end
				local sopts = opts.servers[server]
				local setup = opts.setup[server] or opts.setup["*"]
				local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
				if setup and setup(server, sopts) then
				else
					vim.lsp.config(server, sopts) -- configure the server
					if not use_mason then
						vim.lsp.enable(server)
					end
				end
				return use_mason
			end

			local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
			require("mason-lspconfig").setup({
				ensure_installed = vim.list_extend(install, require("mason-lspconfig").ensure_installed or {}),
			})
		end),
	},

	-- cmdline tools and lsp servers
	{

		"mason-org/mason.nvim",
		cmd = "Mason",
		keys = {
			{ "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
		},
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = vim.list_extend(ensure_installed, {}),
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},

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
