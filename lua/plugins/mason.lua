local ensure_installed = {
	-- -- defaults
	-- "prettier",
	-- "prettierd",
	-- "dprint",
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
	-- "rust-analyzer",
	-- -- sql
	"sqruff",
	-- -- python
	"pyright",
	"ruff",
	-- -- toml
	-- "taplo",
	-- -- yaml
	-- "yaml-language-server",
	-- "yamllint",
	-- -- "yq",
}

return {

	-- {
	-- 	"mason-org/mason-lspconfig.nvim",
	-- 	opts = {
	-- 		-- ensure_installed = { "lua_ls" },
	-- 		automatic_enable = true,
	-- 	},
	-- 	dependencies = {
	-- 		{
	-- 			"mason-org/mason.nvim",
	-- 			opts = {},
	-- 			keys = {
	-- 				{ "<leader>m", "<cmd>Mason<cr>", "n", silent = true, desc = "Mason" },
	-- 			},
	-- 		},
	-- 		"neovim/nvim-lspconfig",
	-- 		"saghen/blink.cmp",
	-- 	},
	-- 	config = function()
	-- 		local registry = require("mason-registry")
	-- 		for _, pkg_name in pairs(ensure_installed) do
	-- 			local ok, pkg = pcall(registry.get_package, pkg_name)
	-- 			if ok then
	-- 				if not pkg:is_installed() then
	-- 					pkg:install()
	-- 				end
	-- 			end
	-- 		end
	-- 	end,
	-- },

	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	event = { "BufRead", "BufNewFile" },
	-- 	dependencies = {
	-- 		--{ "WhoIsSethDaniel/mason-tool-installer.nvim", opts = {} },
	-- 		--{ "saghen/blink.cmp" },
	-- 	},
	-- 	opts = function()
	-- 		---@class PluginLspOpts
	-- 		local ret = {
	-- 			---@type vim.diagnostic.Opts
	-- 			diagnostics = require("diagnostics"),
	-- 			-----@type lspconfig.options
	-- 			servers = {
	-- 				lua_ls = {
	-- 					-- Use this to add any additional keymaps for specific lsp servers
	-- 					-- ---@type LazyKeysSpec[]
	-- 					-- keys = {},
	-- 					settings = {
	-- 						Lua = {
	-- 							workspace = {
	-- 								checkThirdParty = false,
	-- 							},
	-- 							codeLens = {
	-- 								enable = true,
	-- 							},
	-- 							completion = {
	-- 								callSnippet = "Replace",
	-- 							},
	-- 							doc = {
	-- 								privateName = { "^_" },
	-- 							},
	-- 							hint = {
	-- 								enable = true,
	-- 								setType = false,
	-- 								paramType = true,
	-- 								paramName = "Disable",
	-- 								semicolon = "Disable",
	-- 								arrayIndex = "Disable",
	-- 							},
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		}

	-- 		return ret
	-- 	end,
	-- 	-- config = function(_, opts)
	-- 	-- 	local servers = opts.servers
	-- 	-- 	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	-- 	-- 	local has_blink, blink = pcall(require, "blink.cmp")
	-- 	-- 	local capabilities = vim.tbl_deep_extend(
	-- 	-- 		"force",
	-- 	-- 		{},
	-- 	-- 		vim.lsp.protocol.make_client_capabilities(),
	-- 	-- 		has_cmp and cmp_nvim_lsp.default_capabilities() or {},
	-- 	-- 		has_blink and blink.get_lsp_capabilities() or {},
	-- 	-- 		opts.capabilities or {}
	-- 	-- 	)

	-- 	-- 	--local lspconfig = require("lspconfig")
	-- 	-- 	--for server, config in pairs(opts.servers) do
	-- 	-- 	--	-- passing config.capabilities to blink.cmp merges with the capabilities in your
	-- 	-- 	--	-- `opts[server].capabilities, if you've defined it
	-- 	-- 	--	config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
	-- 	-- 	--	lspconfig[server].setup(config)
	-- 	-- 	--end

	-- 	-- 	-- local ensure_installed = vim.tbl_keys(servers or {})
	-- 	-- 	-- vim.list_extend(ensure_installed, {})
	-- 	-- 	--require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	-- 	-- 	---@type MasonLspconfigSettings
	-- 	-- 	require("mason-lspconfig").setup({
	-- 	-- 		ensure_installed = {},
	-- 	-- 		automatic_enable = true,
	-- 	-- 		automatic_installation = false,
	-- 	-- 		handlers = {
	-- 	-- 			function(server_name)
	-- 	-- 				local server = servers[server_name] or {}
	-- 	-- 				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
	-- 	-- 				local server_configs = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) or {}
	-- 	-- 				if server_configs[server_name] then
	-- 	-- 				  vim.lsp.enable(server_configs[server_name])
	-- 	-- 				else
	-- 	-- 					require("lspconfig")[server_name].setup(server)
	-- 	-- 				end
	-- 	-- 			end,
	-- 	-- 		},
	-- 	-- 	})

	-- 	-- 	-- load custom lsp configs
	-- 	-- end,
	-- },

  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>m", "<cmd>Mason<cr>", "n", silent = true, desc = "Mason" },
    },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = vim.list_extend(ensure_installed, {}),
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
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
