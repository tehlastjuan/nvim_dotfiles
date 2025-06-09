return {

	-- formatter
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				astro = { "prettier" },
				c = { name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
				css = { "prettier" },
				go = { "gofumpt", "golines", "goimports" },
				graphql = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				javascriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				json = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				jsonc = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				less = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				php = { "php-cs-fixer" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				ruby = { "rubocop" },
				rust = { name = "rust_analyzer", timeout_ms = 500, lsp_format = "prefer" },
				scss = { "prettier" },
				sh = { "shfmt" },
				sql = { "sqruff" },
				typescript = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				typescriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				yaml = { "yq", "prettier" },
				-- For filetypes without a formatter:
				["_"] = { "trim_whitespace", "trim_newlines" },
			},
			format_on_save = false,
			--format_on_save = {
			--	lsp_fallback = true,
			--	async = false,
			--	quiet = false,
			--	timeout_ms = 2000,
			--},
			formatters = {
				shfmt = {
					--prepend_args = { "-i", "2" },
					prepend_args = { "-i", "0", "-sr", "-kp" },
				},
			},
		},

		init = function()
			-- Use conform for gq.
			vim.opt.formatexpr = "v:lua.require'conform'.format.formatexpr()"
			-- Start auto-formatting by default
			--vim.g.autoformat = true
		end,
	},
}
