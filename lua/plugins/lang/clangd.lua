return {

	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		config = function() end,
		opts = {
			inlay_hints = {
				inline = false,
			},
			ast = {
				--These require codicons (https://github.com/microsoft/vscode-codicons)
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					specifier = "",
					statement = "",
					["template argument"] = "",
				},
				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
			},
		},
	},

	---@type vim.lsp.Config
	{
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--header-insertion=iwyu",
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"--fallback-style=llvm",
		},
		filetypes = { "c", "cpp" },
		capabilities = {
			offsetEncoding = { "utf-16" },
		},
		root_markers = {
			"Makefile",
			"configure.ac",
			"configure.in",
			"config.h.in",
			"meson.build",
			"meson_options.txt",
			"build.ninja",
			"compile_commands.json",
			"compile_flags.txt",
		},
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			clangdFileStatus = true,
		},
		setup = {
			clangd = function(_, opts)
				require("clangd_extensions").setup(vim.tbl_deep_extend("force", {}, { server = opts }))
				return false
			end,
		},
	},

	{
		"mfussenegger/nvim-dap",
		optional = true,
		dependencies = {
			"mason-org/mason.nvim",
			optional = true,
			opts = { ensure_installed = { "codelldb" } },
		},
		opts = function()
			local dap = require("dap")
			if not dap.adapters["codelldb"] then
				require("dap").adapters["codelldb"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "codelldb",
						args = {
							"--port",
							"${port}",
						},
					},
				}
			end
			for _, lang in ipairs({ "c" }) do
				dap.configurations[lang] = {
					{
						type = "codelldb",
						request = "launch",
						name = "Launch file",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
					},
					{
						type = "codelldb",
						request = "attach",
						name = "Attach to process",
						pid = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},
}
