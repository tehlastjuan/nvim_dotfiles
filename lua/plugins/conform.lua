local prettier = { "prettierd", "prettier", stop_after_first = true }

return {

	-- formatter
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		event = "BufWritePre",
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				{ "n", "v" },
				desc = "Format",
			},
			{
				"<leader>cF",
				function()
					require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
				end,
				{ "n", "v" },
				desc = "Format Injected Langs",
			},
		},
		opts = {
			notify_on_error = false,
      --stylua: ignore
			formatters_by_ft = {
				bash            = { "shfmt" },
				c               = { "clang-format", name = "clangd", timeout_ms = 500, lsp_format = "prefer" },
        cmake           = { "cmake-format" },
				css             = { "prettier" },
				go              = { "gofumpt", "golines", "goimports" },
				graphql         = { prettier },
        handlebars      = { prettier },
				html            = { "prettier" },
				javascript      = { "prettier", "eslint", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				javascriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				json            = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				jsonc           = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				less            = { "prettier" },
				lua             = { "stylua" },
				markdown        = { "prettier" },
        php             = { "intelephense", "php-cs-fixer" },
				python          = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				ruby            = { "rubocop" },
				rust            = { name = "rust_analyzer", timeout_ms = 500, lsp_format = "prefer" },
				scss            = { "prettier" },
				sh              = { "shfmt" },
				sql             = { "sqruff" },
				typescript      = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				typescriptreact = { "prettier", name = "dprint", timeout_ms = 500, lsp_format = "fallback" },
				yaml            = { "yq", "prettier" },
				-- For filetypes without a formatter:
				["_"] = { "trim_whitespace", "trim_newlines" },
			},
			format_on_save = false,
			formatters = {
				-- astyle = {
				--   command = "astyle",
				--   prepend_args = { "-s2", "-c", "-J", "-n", "-q", "-z2", "-xC80" },
				-- },
				-- ["clang-format"] = {
				--   command = "clang-format",
				--   prepend_args = { "--style=file", "-i" },
				-- },
				-- ["cmake-format"] = {
				--   command = "cmake-format",
				--   prepend_args = { "-i" },
				-- },
				-- nix = {
				--   command = "nixpkgs-fmt",
				-- },
				-- ["php-cs-fixer"] = {
				--   command = "php-cs-fixer",
				--   prepend_args = { "fix", "--rules=@PSR12" },
				-- },
				-- prettier = {
				--   command = "prettier",
				--   prepend_args = { "-w" },
				-- },
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
