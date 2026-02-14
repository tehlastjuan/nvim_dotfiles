return {

	-- clisp

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "ansiblels" },
		},
	},




	{
		config = function()
			local lspconfig = vim.lsp.config
			-- Check if the config is already defined (useful when reloading this file)
			if not lspconfig.configs.cl_lsp then
				lspconfig.configs.cl_lsp = {
					default_config = {
						cmd = { vim.env.HOME .. "~/.roswell/bin/cl-lsp" },
						filetypes = { "lisp" },
						root_dir = lspconfig.util.find_git_ancestor,
						settings = {},
					},
				}
			end
		end,
	},

	{
		"monkoose/nvlime",
		dependencies = {
			"monkoose/parsley",
			"adolenc/cl-neovim",
			"gpanders/nvim-parinfer",
			{
				"nvim-treesitter/nvim-treesitter",
				opts = function(_, opts)
					if type(opts.ensure_installed) == "table" then
						vim.list_extend(opts.ensure_installed, { "commonlisp" })
					end
				end,
			},
		},
		cmp_enabled = function()
			vim.g.nvlime_config.cmp.enabled = true
		end,
		config = function()
			require("cmp").setup.filetype({ "lisp" }, {
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "nvlime" },
				},
			})
		end,
	},
}
